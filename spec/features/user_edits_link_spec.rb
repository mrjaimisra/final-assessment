require 'rails_helper'

RSpec.feature "User edits a link", type: :feature do
  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:link) { Link.create(url: "http://link.com",
                            title: "Link",
                            user_id: user.id) }
  before do
    signin
  end

  scenario "successfully" do
    visit user_links_path(user)
    click_on "Edit"

    expect(current_path).to eq(edit_user_link_path(user, link))

    fill_in "Url", with: "http://google.com"
    fill_in "Title", with: "Things to don't"
    click_on "Submit"

    expect(current_path).to eq(user_links_path(user))
    expect(page).to have_content("Things to don't")
  end

  scenario "unsuccessfully with an invalid Url" do
    visit user_links_path(user)
    click_on "Edit"

    expect(current_path).to eq(edit_user_link_path(user, link))

    fill_in "Url", with: "http"
    fill_in "Title", with: "Things to don't"
    click_on "Submit"

    expect(current_path).to eq(edit_user_link_path(user, link))
  end
end
