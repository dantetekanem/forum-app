require "rails_helper"

RSpec.feature "Forgot password", type: :feature do
  let(:user) { users(:jon) }

  scenario "Send reset password instructions" do
    reset_password(user.email)

    expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.')
  end

  scenario "Wrong email" do
    reset_password('no@domain.com')

    expect(page).to have_content('Email not found')
  end

  scenario "Empty email" do
    reset_password('')

    expect(page).to have_content("Email can't be blank")
  end
end
