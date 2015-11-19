require 'rails_helper'

RSpec.feature "User renames a list", type: :feature do
  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:list) { List.create(title: "Things To Do", user_id: user.id)}

  before do
    signin
  end

  scenario "successfully" do
    visit user_links_path(user)
    click_on list.title

    expect(current_path).to eq(user_list_path(user, list))

    click_on "Edit"

    expect(current_path).to eq(edit_user_list_path(user, list))

    fill_in "Title", with: "Things to don't"
    click_on "Submit"

    expect(current_path).to eq(user_list_path(user, list))
    expect(page).to have_content("Things to don't")
  end

  scenario "unsuccessfully" do
    visit user_links_path(user)
    click_on list.title

    expect(current_path).to eq(user_list_path(user, list))

    click_on "Edit"

    expect(current_path).to eq(edit_user_list_path(user, list))

    fill_in "Title", with: ""
    click_on "Submit"

    expect(current_path).to eq(user_list_path(user, list))
  end


end
