module FeatureHelpers
  def sign_up_with(name, email, username, password, password_confirmation)
    visit new_user_registration_path

    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Username', with: username
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password

    click_button 'Sign Up'
  end

  def sign_in_with(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end

  def reset_password(email)
    visit new_user_password_path

    fill_in 'Email', with: email
    click_button 'Send me reset password instructions'
  end

  def confirmation_instructions(email)
    visit new_user_confirmation_path

    fill_in 'Email', with: email
    click_button 'Resend confirmation instructions'
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end
