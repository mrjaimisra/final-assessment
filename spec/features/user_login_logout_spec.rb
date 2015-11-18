require 'rails_helper'

RSpec.feature "User can sign in", type: :feature do
  let!(:user) { User.create(username: "Jai", password: "123") }

  scenario "successfully" do
    visit root_path

    within(".header-nav") do
      click_on "Sign in"
    end

    expect(current_path).to eq(signin_path)

    within(".signin-form") do
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_on "Sign in"
    end

    expect(current_path).to eq(user_links_path(user))
    expect(page).to have_content(user.username)
  end

  scenario "and then sign out" do
    signin

    within(".header-nav") do
      click_link "Sign out"
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_link("Sign in")

    within(".navbar") do
      expect(page).to_not have_content(user.username)
    end
  end
end
