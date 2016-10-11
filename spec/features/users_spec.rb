require 'rails_helper'

feature 'User Account' do
  let(:user){ create(:user) }
  let(:num_secret) { 3 }
  before do
    visit(root_path)

  end
  scenario 'I want to view all the secrets' do
    user.secrets = create_list(:secret, num_secret)
    user.save!
    visit(secrets_path)
    page.assert_selector('tbody td', :count => 12)
  end

  scenario 'I want to sign up' do
    visit new_user_path
    within('form#new_user') do
      fill_in 'user_name', :with => 'Jimmy'
      fill_in 'user_email', :with => 'Jimmy@email.com'
      fill_in 'user_password', :with => 'foobar123'
      fill_in 'user_password_confirmation', :with => 'foobar123'
      click_button 'Create User'
    end
    expect(page).to have_content "User was successfully created."
  end

  scenario 'As a signed up user, I want to sign in' do
    my_user = create(:user)
    sign_in(my_user)
    expect(page).to have_content "You've successfully signed in"
    expect(page).to have_content "Listing secrets"
  end

  scenario 'As a signed in user, I want to sign out' do
    my_user = create(:user)
    sign_in(my_user)
    sign_out
    expect(page).to have_content "You've successfully signed out"
  end

  scenario 'As a signed-in user, I want to be able to create a secret' do
    my_user = create(:user)
    sign_in(my_user)
    click_link "New Secret"
    fill_in "Title", with: "Hello?"
    fill_in "Body", with: "There"
    click_button "Create Secret"
    expect(page).to have_content "Secret was successfully created."
  end

  scenario 'As a signed-in user, I want to be able to edit one of my secrets' do
    my_user = create(:user)
    secret = create(:secret, author: my_user)
    sign_in(my_user)
    click_link 'Edit'
    fill_in "Body", with: "Suckers"
    click_button "Update Secret"
    expect(page).to have_content "Secret was successfully updated."
  end

  scenario 'As a signed-in user, I want to be able to delete one of my secrets' do
    my_user = create(:user)
    secret = create(:secret, author: my_user)
    sign_in(my_user)
    click_link "Destroy"
    expect(page).to have_content "Secret was successfully destroyed."
  end

  #Sad Paths
  scenario 'User, should not be created without email' do
    visit new_user_path
    fill_in 'user_name', :with => 'Jimmy'
    fill_in 'user_password', :with => 'foobar123'
    fill_in 'user_password_confirmation', :with => 'foobar123'
    click_button 'Create User'
    expect(page).not_to have_content "User was successfully created."
    expect(page).to have_content "Email can't be blank"
  end

  scenario 'Secret cannot be created by a signed out user' do
    visit new_secret_path
    expect(page).to have_content "Not authorized, please sign in!"
    expect(current_path).to eq(new_session_path)
  end

  scenario 'User cannot edit other users secrets' do
    user1 = create(:user)
    secret1 = create(:secret, author: user1)
    user2 = create(:user)
    sign_in(user2)
    expect(page).not_to have_content "Edit"
    sign_out
    sign_in(user1)
    expect(page).to have_content "Edit"
  end

  scenario 'User cannot delete other users secrets' do
    user1 = create(:user)
    secret1 = create(:secret, author: user1)
    user2 = create(:user)
    sign_in(user2)
    expect(page).not_to have_content "Destroy"
    sign_out
    sign_in(user1)
    expect(page).to have_content "Destroy"
  end
end
