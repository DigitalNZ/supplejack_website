RSpec.feature 'A user signs in' do
  let(:kereru) {Kereru.new}
  let(:password) {'boosting'}
  let(:user) {create(:user, password: password, password_confirmation: password)}

  before do
    kereru.home.load
    kereru.home.menu.login_link.click
  end

  scenario 'with valid credentials' do
    within kereru.login.login_form do
      fill_in "Email", with: user.email
      fill_in "Password", with: password
      click_button "Log in"
    end

    expect(page).to have_content("Signed in successfully")
  end

  scenario 'with invalid credentials' do
    within kereru.login.login_form do
      fill_in "Email", with: user.email
      fill_in "Password", with: "foo"
      click_button "Log in"
    end

    expect(page).to have_content("Invalid email or password")
  end
end
