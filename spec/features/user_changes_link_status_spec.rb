require 'rails_helper'

RSpec.feature "User changes the status of a link", type: :feature do

  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:link) { Link.create(url: "http://link.com",
                            title: "List1",
                            user_id: user.id) }


  before do
    signin
  end

  xscenario "to Unread", js: true do
    visit user_links_path(user)

    expect(page).to have_link(link.title)

    click_on "Make Unread"

    expect(current_path).to eq(user_links_path(user))
    expect(page).to have_content("Make Read")
    expect(page).to have_css(".read")

    click_on "All Links"
    expect(current_path).to eq(user_links_path(user))
    expect(page).to have_content("Make Unread")
    expect(page).to have_css(".read")
  end

  xscenario "to Read", js: true do
    visit user_links_path(user)

    expect(page).to have_link(link.title)

    click_on "Make Unead"

    expect(current_path).to eq(user_links_path(user))
    expect(page).to have_content("Make Unread")
    expect(page).to have_css(".read")

    click_on "All Links"
    expect(current_path).to eq(user_links_path(user))
    expect(page).to have_content("Make Read")
    expect(page).to have_css(".unread")
  end
end
