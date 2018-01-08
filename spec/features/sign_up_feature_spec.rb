require "rails_helper"

RSpec.feature "Sign up", type: :feature do
  let(:name) { "Leonardo Pereira" }
  let(:email) { "contato@leonardopereira.com" }
  let(:username) { "leonardopereira" }
  let(:password) { "change123" }

  scenario "Sign up user" do
    sign_up_with(name, email, username, password, password)

    expect(page).to have_content('You need to sign in or sign up before continuing.')
    expect(User.last.email).to eq email
  end

  scenario "Sign up with wrong email" do
    sign_up_with(name, 'invalid_email', username + "2", password, password)

    expect(page).to have_content('1 error prohibited')
    expect(page).to have_content('Email is invalid')
  end

  scenario "Sign up with same email" do
    User.create(
      name: name,
      email: email,
      username: username,
      password: password,
      password_confirmation: password
    )
    sign_up_with(name, email, username + '2', password, password)

    expect(page).to have_content('1 error prohibited')
    expect(page).to have_content('Email has already been taken')
  end

  scenario "Sign up with blank name" do
    sign_up_with('', "second-" + email, username + "2", password, password)

    expect(page).to have_content('1 error prohibited')
    expect(page).to have_content("Name can't be blank")
  end

  scenario "Sign up with empty username" do
    sign_up_with(name, "second-" + email, '', password, password)

    expect(page).to have_content('2 errors prohibited')
    expect(page).to have_content("Username can't be blank")
    expect(page).to have_content("Username is invalid")
  end

  scenario "Sign up with invalid username" do
    sign_up_with(name, "second-" + email, '$$$dolarsign$$$ user', password, password)

    expect(page).to have_content('1 error prohibited')
    expect(page).to have_content('Username is invalid')
  end

  scenario "Sign up with blank password" do
    sign_up_with(name, "second-" + email, username + "2", '', '')

    expect(page).to have_content('1 error prohibited')
    expect(page).to have_content("Password can't be blank")
  end
end
