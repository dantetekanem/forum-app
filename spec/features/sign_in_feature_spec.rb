require "rails_helper"

RSpec.feature "Sign in", type: :feature do
  scenario "With a valid e-mail and password" do
    sign_in_with 'jon@house-stark.com', 'change123'

    expect(page).to have_content('Sign out')
  end

  scenario "With invalid e-mail and password" do
    sign_in_with 'invalid_email', 'change123'

    expect(page).to have_content('Log in')
  end

  scenario "With blank password" do
    sign_in_with 'jon@house-stark.com', ''

    expect(page).to have_content('Log in')
  end
end
