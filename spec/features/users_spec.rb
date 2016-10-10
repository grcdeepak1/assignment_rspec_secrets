require 'rails_helper'

feature 'As a visitor, I want to view all secrets' do
  let(:user){ create(:user) }
  let(:num_secret) { 3 }
  before do
    user.secrets = create_list(:secret, num_secret)
    user.save!
    visit(secrets_path)
  end
  scenario 'I want to view all the secrets' do
    page.assert_selector('tbody td', :count => 12)
  end
end

feature 'As a visitor, I want to sign up' do
  before do
    visit new_user_path
  end
  scenario 'I want to sign up' do
    within('form#new_user') do
      fill_in 'user_name', :with => 'Jimmy'
      fill_in 'user_email', :with => 'Jimmy@email.com'
      fill_in 'user_password', :with => 'foobar123'
      fill_in 'user_password_confirmation', :with => 'foobar123'
      click_button 'Create User'
    end
    expect(page).to have_content "User was successfully created."
  end
end

# feature 'test' do
#   scenario "home" do
#     visit(users_path)
#     #save_and_open_page
#     # print page.html
#     expect(current_path).to eq(users_path)
#   end

#   scenario "new user link" do
#     visit(users_path)
#     find_link('New User').visible?
#   end
# end

# feature 'Authentication' do
#   let(:user){ create(:user) }
#   before do
#     visit login_path
#   end

#   context "with improper credentials" do
#     before do
#       user.email = user.email + "x"
#       sign_in(user)
#     end

#     scenario "does not allow sign in" do
#       expect(page).to have_content "We couldn't sign you in"
#     end
#   end
# end
