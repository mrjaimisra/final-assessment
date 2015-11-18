require 'rails_helper'

RSpec.feature "User adds a link", type: :feature do

  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:list) { Link.create(url: "http://link.com",
                            title: "List1",
                            user_id: user.id) }

  before do
    signin
  end

  scenario "successfully" do
    visit user_links_path(user)

    fill_in "Url", with: "http://another-link.com"
    fill_in "Title", with: "New Link"
    click_on "Submit"

    new_link = Link.last

    expect(current_path).to eq(user_links_path(user))
    expect(page).to have_content(new_link.title)
  end

  scenario "unsuccessfully without a url" do
    visit user_links_path(user)

    fill_in "Url", with: ""
    fill_in "Title", with: "New Link"
    click_on "Submit"

    expect(page).to have_content("Url can't be blank")
  end

  scenario "unsuccessfully without a title" do
    visit user_links_path(user)

    fill_in "Url", with: "http://validurl.com"
    fill_in "Title", with: ""
    click_on "Submit"

    expect(page).to have_content("Title can't be blank")
  end

  scenario "unsuccessfully with an invalid url" do
    visit user_links_path(user)

    fill_in "Url", with: "invalidurl"
    fill_in "Title", with: "New Link"
    click_on "Submit"

    expect(page).to have_content("Url is not a valid URI")
  end
end
