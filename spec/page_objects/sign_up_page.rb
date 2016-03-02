require_relative 'shared/layout_page'

class SignUpPage < LayoutPage
  set_url '/users/sign_up'

  element :registration_form, "#new_user"
end
