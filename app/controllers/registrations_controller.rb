# Registraion controller is used for user creation
class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(user_params)

    # FIXME: simple workaround for registration field not
    # having name/username fields
    # should be replace with actual form fields in a later story
    resource.name = resource.username = resource.email.split('@').first

    if resource.save && resource.create_user_and_default_set
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      resource.destroy unless resource.new_record?
      clean_up_passwords resource
      respond_with resource
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
