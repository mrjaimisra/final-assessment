def signin
  visit root_path

  within(".header-nav") do
    click_link "Sign in"
  end

  within(".signin-form") do
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end