namespace :custom_update do
  desc "Testing"
  task update_pxd_project: :environment do
    current_user = User.find_by_email Rails.env.production? ? 'alexgr200@gmail.com' : 'admin@example.com'
    project_slug = Rails.env.production? ? 'proxio-developers' : 'pxd'
    @project = Project.find_from_slug!(project_slug)

    targets = {
    'country-label' => "Country",
    'cover-image' => "Cover Image",
    'create-a-team' => "Create a multicultural team composed of agents with all types specialties and expertise.",
    'current-psw' => "Current password",
    days: "days",
    delete: "Delete",
    'delete-amenity-warning' => "Are you sure you want to delete this section?",
    'delete-my-account' => "Cancel account",
    developer: "Developer",
    developers: "Developers",
    development: "Development",
    'development-logo' => "Development Logo",
    'development-name' => "Name of Development",
    documents: "Documents",
    edit: "Edit",
    'edit-cover-image' => "Edit cover image",
    'edit-image' =>"Edit image",
    'edit-profile' =>"Edit profil",
    'edition-ended' =>"Information updated",
    'email' =>"Email",
    'email-and-clients' =>"Email or print marketing flyers available in the language of all your clients",
    'english' =>"English",
    'enhance-your-team' =>"Strengthen your team",
    'enter2-account' =>"Login to my account",
    'enter-account' =>"Login to my account",
    'enter-current-pws' =>"Please enter your current password to confirm changes",
    'equestrian-properties' =>"Equestrian properties",
    'example-especiality' =>"Example: Specializes in condos. Your trusted real estate agent, etc.",
    'exit' =>"Sign Out",
    'external-agents' =>"External Agents",
    'facebook' =>"Facebook:",
    'fb-copy-paste-url' =>"Copy and paste the url of your Facebook profile",
    'featured-developments' =>"FEATURED DEVELOPMENTS",
    'forgot-psw' =>"Did you forget your password?",
    'french' =>"French",
    'full-name' =>"Full Name",
    'general-description' =>"General Description",
    'general-message' =>"General Message",
    'get-access-world' =>"Gain access to more than 50 countries around the world",
    'golf-properties' =>"Golf properties",
    'hi' =>"Hi",
    'home' =>"HOME",
    'images' =>"Images",
    'italian' =>"Italian",
    'japanese' =>"Japanese",
    'languajes' =>"Languages",
    'leave-blank-if-no-psw-change' =>"Leave blank if you do not wish to change your password",
    'li-copy-paste-url' =>"Copy and paste the url of your Linkedin profile",
    'linkedin' =>"LinkedIn:",
    'locality-label' =>"Colony",
    'location' =>"Location:",
    'location-help' =>"Try to be as accurate as possible, you can move the pointer to the right place.",
    'luxury-homes' =>"Luxury homes",
    'make-proy-likes-twits' =>"Become part of the property conversation as clients share, post, pin and tweet your listings!",
    'min-image-size-msj' =>"(The image should be 1000px X 600px minimum, and will be used in ALL marketing material.)",
    'month' =>"month",
    'my-agent-team' =>"My Team of Advisors",
    'my-agents' =>"My agents",
    'my-agents-team' =>"My team",
    'my-apps' =>"My Applications",
    'my-clients' =>"My clients",
    'my-developments' =>"MY DEVELOPMENTS",
    'my-records' =>"My records",
    'my-subscriptors' =>"My Subscribers",
    'name-label' =>"Name",
    'near-to' =>"Close to",
    'net-developments' =>"Development Search",
    'new-development' =>"New developments",
    'new-homes' =>"New homes",
    'new-subscriber' =>"has a new subscriber",
    'no-file-chosen' =>"No file chosen",
    'no-pending-requests' =>"You have no pending requests",
    'other' =>"Other",
    'our-company' =>"Our Company",
    'our-specialities' =>"Our Specialties",
    'password' =>"Password",
    'phone' =>"Telephone number",
    'powered-by' => "Powered by: © 2013 Proxio -",
    'print' =>"Print",
    'profile' =>"Profile",
    'profile-edition' =>"Edit Profile",
    'profile-image' =>"Profile Picture",
    'profile-updated-successfully' =>"Profile Sucessfully Updated",
    'profit-help-text' =>"Please state the commission that you will give to agents for this development",
    'profit-label' =>"Commission",
    'prospects' =>"Potential clients",
    'proxio-Social-Search' =>"Proxio SocialSearch",
    'proxio-ss-fb-app' =>"Proxio SocialSearch Facebook app",
    'psw-requirements' =>"The password must contain at least 8 characters, containing both numbers and letters",
    'public-subscriptions' =>"Public Subscriptions",
    'publish' =>"Post",
    'publish-new-document' =>"",
    'publish-new-image' =>"Posted a new image",
    'publish-new-map' =>"posted a new plan",
    'publish-new-post' =>"posted a new update",
    'publish-new-price-document' =>"posted a new price list",
    'publish-new-video' =>"posted a new video",
    'real-state-brokers' =>"Real state brokers",
    'recommended-dev' =>"Recommended Developments",
    'reference-label' =>"Reference",
    'register-by' =>"Registered by:",
    'register-date' =>"Registered date:",
    'register-me' =>"Sign Up",
    'remark-dev' =>"Featured developments",
    'remind-me' =>"Remember Me",
    'remove-subscription' =>"Cancel subscription",
    'requests' =>"My Requests",
    'resort-second-homes' =>"Resort & second homes",
    'retirement-properties' =>"Retirement Properties",
    'sales-kit' =>"Sales Kit",
    'save' =>"Save",
    'save-and-continue' =>"Save and continue",
    'say-clients' =>"What do our clients say?",
    'Search' =>"Search",
    'section-start' =>"Start Session",
    'see-doc' =>"See document",
    'see-map' =>"Map Plan",
    'see-more-activity' =>"See more activity",
    'see-profile' =>"See profile",
    'see-video' =>"Watch video",
    'select' =>"Select",
    'select-development' =>"Please select a development",
    'select-plan' =>"Select a plan. You can cancel it at anytime.",
    'select-to-print-or-send' =>"Select the box to print or send developments",
    'select-your-skills' =>"Please select your strengths",
    'send-dev' =>"Send Development",
    'signed-in-successfully' =>"SIGNED IN SUCCESSFULLY.",
    'slogan' =>"Slogan",
    'spanish' =>"Spanish",
    'state-label' =>"State",
    'street-label' =>"Street",
    'street-number-label' =>"Name of Street",
    'subscriptions' =>"Subscriptions",
    'subscriptions-request' =>"Subscription requests",
    'team' =>"TEAM",
    'title' =>"Title",
    'turn-fb-solution' =>"Turn Facebook into your best marketing solution!",
    'tw-copy-paste-url' =>"Copy and paste the url of your Twitter profile",
    'twiter' =>"Twitter:",
    'update' =>"Update",
    'updated-basic-info' =>"Basic information updated",
    'updated-dev-info' =>"Development information Updated",
    'updated-document' =>"has updated the document",
    'updated-map' =>"updated the plan",
    'updated-section-content' =>"has updated a section of content",
    'updated-terms-condition' =>"Updated Terms and Conditions of developement",
    'updated-video' =>"updated the video",
    'url' =>"URL",
    'vacation-properties' =>"Vacation homes",
    'videos' =>"Videos",
    'visit-dev' =>"See Development",
    'we-are-group' =>"We are a group of people organized and committed to your property.",
    'wellcome-huge-net' =>"Welcome to the largest network of agents in the world",
    'what-r-u-looking' =>"What are you searching for?",
    'work-agents-clients' =>"Work with agents and clients located around the world",
    'write-a-photo-title' =>"Please provide name of photo",
    'write-a-title' =>"Write title",
    'write-company-desc' =>"Please describe your company",
    'write-doc-name' =>"Please name document",
    'write-url-video' =>"Enter the url address (YouTube or Vimeo)",
    'your-public-profile' =>"This is the public URL to your profile:",
    'zone-label' =>"Zone" }

    targets.each do |i, k|
      puts i.to_s, @project.id.to_s
      @key = Key.find_from_slug!(i.to_s, @project.id.to_s) rescue next

      @translation = @key.translations.where(rfc5646_locale: 'en').first!

      # Need to save true copy_was because assign_attributes will push back the cache
      @translation.freeze_tracked_attributes
      @translation.assign_attributes copy: k.to_s

      @translation.translator = current_user if @translation.copy_was != @translation.copy
      @translation.modifier = current_user

      if @translation.present?
        # the only thing that can be edited is copy, so optimize DB calls if this
        # is not a copy edit
        if @translation.copy_was != @translation.copy # copy_changed? can be true even if the copy wasn't changed...
          @translation.preserve_reviewed_status = current_user.reviewer?
          @translation.save
        else
          # if the current user is a reviewer, treat this as an approve action; this
          # makes tabbing through fields act as approval in the front-end
          if current_user.reviewer?
            @translation.reviewer                 = current_user
            @translation.approved                 = true
            @translation.preserve_reviewed_status = true
            @translation.save
          end
        end
      end
    end
  end
end