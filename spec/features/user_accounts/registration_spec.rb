RSpec.feature 'User registration', focus: true do
  let(:kereru) {Kereru.new}

  scenario 'a user registers with valid inputs' do
    kereru.home.load
    kereru.home.menu.sign_up_link.click
    
    within kereru.sign_up.registration_form do
      fill_in "Email", with: "foo@boost.co.nz"
      fill_in "Password", with: "boosting"
      fill_in "Password confirmation", with: "boosting"
      click_button "Sign up"
    end

    expect(page).to have_content("signed up successfully")
  end
end
