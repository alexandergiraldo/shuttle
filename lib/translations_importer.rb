class TranslationsImporter

  def initialize(source_commit, target_commit = nil, source_locale = 'es', target_locale = 'en')
    @current_user = User.find_by_email Rails.env.production? ? 'alexgr200@gmail.com' : 'admin@example.com'
    project_slug = Rails.env.production? ? 'proxio-developers' : 'pxd'
    @project = Project.find_from_slug!(project_slug)

    @target_commit = target_commit.present? ? @project.commits.for_revision(target_commit).first! : @project.commits.last
    @source_commit = @project.commits.for_revision(source_commit).first!
    @source_locale = source_locale
    @target_locale = target_locale
  end

  def process
    i18n_keys = @target_commit.keys.map(&:original_key)
    commit_id1 = @target_commit.id
    commit_id2 = @source_commit.id
    i18n_keys.each do |i18n_key|
      keys = Key.search(load: {include: [:translations, :slugs]}) do
        query { string "commit_ids:\"#{commit_id1}\",\"#{commit_id2}\"" }
        filter :prefix, original_key_exact: i18n_key
      end
      results = keys.results

      if keys.count == 2
        keys_builder(results)
      elsif keys.count > 2
        keys_filter = results.select {|k| k.original_key == i18n_key }
        keys_builder(keys_filter)
      end
    end

  end

  def keys_builder(results)
    es_key = results.find {|k| k.source.include?("pxd.#{@source_locale}")}
    en_key = results.find {|k| k.source.include?("pxd.#{@target_locale}")}
    return false unless es_key.present? && en_key.present?
    copy_translations(es_key,en_key) if es_key.original_key == en_key.original_key
  end

  def copy_translations(source_key, target_key)
    source_key.translations.each do |translation|
      next if translation.copy.blank?
      target_translation = target_key.translations.find { |t| t.rfc5646_locale == translation.rfc5646_locale }
      next if target_translation.approved?
      assign_translation(target_translation,translation.copy) if target_translation.present?
    end
  end

  def assign_translation(translation,copy)
    translation.freeze_tracked_attributes
    translation.assign_attributes copy: copy.to_s

      translation.translator = @current_user if translation.copy_was != translation.copy
      translation.modifier = @current_user

      if translation.present?
        # the only thing that can be edited is copy, so optimize DB calls if this
        # is not a copy edit
        if translation.copy_was != translation.copy # copy_changed? can be true even if the copy wasn't changed...
          translation.preserve_reviewed_status = @current_user.reviewer?
          translation.save
        else
          # if the current user is a reviewer, treat this as an approve action; this
          # makes tabbing through fields act as approval in the front-end
          if @current_user.reviewer?
            translation.reviewer                 = @current_user
            translation.approved                 = true
            translation.preserve_reviewed_status = true
            translation.save
          end
        end
      end
  end

end