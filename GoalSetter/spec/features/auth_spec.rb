# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature "Sign up" do
  before :each do
    visit new_user_path
  end

  feature "the signup process" do
    scenario "has a new user page" do
      expect(page).to have_content "Sign Up"
    end

    feature "signing up a user" do
      scenario "shows username on the homepage after signup" do
        expect(page).to have_content "Username"
        expect(page).to have_content "Password"
      end
    end

    scenario "redirects to user's profile and displays user's username on success" do
      sign_up_as_ginger_baker
      # add user name to application.html.erb layout
      expect(page).to have_content 'ginger_baker'
      expect(current_path).to eq(users_path)
    end
  end
end

feature "logging in" do
  before :each do
    visit new_session_path
  end

  scenario "has a sign in page" do
    expect(page).to have_content "Sign In"
  end

  scenario "takes a username and password" do
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  scenario "returns to sign in on failure" do
    visit new_session_path
    fill_in "Username", with: 'ginger_baker'
    fill_in "Password", with: 'hello'
    click_button "Sign In"

    # return to sign-in page
    expect(page).to have_content "Sign In"
    expect(page).to have_content "Username"
  end
  scenario "shows username on the homepage after login" do

  end
end

feature "logging out" do

  scenario "begins with a logged out state"

  scenario "doesn't show username on the homepage after logout"

end
