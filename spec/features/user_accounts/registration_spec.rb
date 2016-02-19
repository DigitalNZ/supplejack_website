RSpec.feature 'A user registers' do
  let(:kereru) {Kereru.new}
  before do
    kereru.home.load
    kereru.home.menu.sign_up_link.click
  end

  scenario 'with valid inputs' do
    within kereru.sign_up.registration_form do
      fill_in "Email", with: "foo@boost.co.nz"
      fill_in "Password", with: "boosting"
      fill_in "Password confirmation", with: "boosting"
      click_button "Sign up"
    end

    expect(page).to have_content("signed up successfully")
    expect(User.count).to eq(1)
  end

  scenario 'with no information' do
    kereru.sign_up.registration_form.click_button "Sign up"

    expect(page).to have_content("2 errors")
    expect(User.count).to eq(0)
  end

  scenario 'with a password under the length limit' do
    within kereru.sign_up.registration_form do
      fill_in "Email", with: "foo@boost.co.nz"
      fill_in "Password", with: "foo"
      fill_in "Password confirmation", with: "foo"
      click_button "Sign up"
    end

    expect(page).to have_content("Password is too short")
  end

  scenario 'with non-matching passwords' do
    within kereru.sign_up.registration_form do
      fill_in "Email", with: "foo@boost.co.nz"
      fill_in "Password", with: "boosting"
      fill_in "Password confirmation", with: "foo"
      click_button "Sign up"
    end

    expect(page).to have_content("Password confirmation doesn't match")
  end
end
