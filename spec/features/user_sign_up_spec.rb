require 'rails_helper'

RSpec.feature "User can sign up for new account", type: :feature do

  scenario "successfully" do
    visit root_path

    click_link "Sign up"

    fill_in "Username", with: "Steve"
    fill_in "Password", with: "123"
    fill_in "Confirm Password", with: "123"
    click_button "Create Account"

    user = User.find_by(username: "Steve")

    expect(current_path).to eq(user_links_path(user))
    expect(page).to have_content("Steve")
  end
end
