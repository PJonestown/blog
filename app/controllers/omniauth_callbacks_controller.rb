class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  #def self.provides_callback_for(provider)
  def self.provides_callbacks_for(provider) 
    class_eval %Q{
      def #{provider}

        @commenter = Commenter.find_for_oath(env["omniauth.auth"],
                                         current_commenter)
        if @commenter.persisted?
          sign_in_and_redirect @commenter, event: :authentication
          flash[:success] = "Signed in #{provider}"

      
        else

          session["devise.#{provider}_data"] = env["omniath_auth"]
          redirect_to new_commenter_registration_path
        end
      end
    }

  end

  [:twitter, :github].each do |provider|
    provides_callbacks_for provider
  end

end
