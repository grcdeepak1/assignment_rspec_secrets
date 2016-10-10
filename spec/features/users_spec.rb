require 'rails_helper'

feature 'test' do
  scenario "home" do
    visit(users_path)
    #save_and_open_page
    # print page.html
    expect(current_path).to eq(users_path)
  end

  scenario "new user link" do
    visit(users_path)
    find_link('New User').visible?
  end
end

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
