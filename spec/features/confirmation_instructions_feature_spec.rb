require "rails_helper"

RSpec.describe "Confirmation instructions", type: :feature do
  let(:user) do
    User.create({
      email: 'test-user@email.com',
      username: 'test',
      name: 'Test user',
      password: 'change123',
      password_confirmation: 'change123',
      confirmation_token: Devise.friendly_token,
      confirmation_sent_at: Time.now
    })
  end

  scenario "Resend confirmation" do
    confirmation_instructions(user.email)

    expect(page).to have_content('You will receive an email with instructions for how to confirm your email address in a few minutes.')
  end

  scenario "Wrong email" do
    confirmation_instructions('not-valid')

    expect(page).to have_content('Email not found')
  end

  scenario "Empty email" do
    confirmation_instructions('')

    expect(page).to have_content("Email can't be blank")
  end
end
