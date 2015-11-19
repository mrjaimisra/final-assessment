require 'rails_helper'

RSpec.feature "User deletes a list", type: :feature do
  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:list) { List.create(title: "Things To Do", user_id: user.id) }
  let!(:link) { Link.create(url: "http://link.com",
                            title: "kfskdshlgsdh",
                            user_id: user.id,
                            list_id: list.id) }

  before do
    signin
  end

  scenario "successfully for list with items" do
    visit user_links_path(user)

    expect(page).to have_content(list.title)
    expect(page).to_not have_content(link.title)

    click_on(list.title)

    expect(current_path).to eq(user_list_path(user, list))

    expect(page).to have_content(list.title)
    expect(page).to have_content(link.title)

    click_on "Delete"

    expect(current_path).to eq(user_links_path(user))
    expect(page).to have_content(link.title)
    expect(page).to_not have_content(list.title)
  end
end