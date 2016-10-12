require 'rails_helper'

describe "layouts/application.html.erb" do
  let( :user ){ create( :user ) }
  let(:num_secrets) { 3 }
  context "non-logged in" do
    before do
      def view.signed_in_user?
        false
      end
      @user = user
      def view.current_user
        @user
      end
    end
    it "logout link is not present" do
      secrets = create_list(:secret, num_secrets)
      assign(:secrets, secrets)
      render
      expect(rendered).not_to match('Logout')
    end
  end

  context "logged-in" do
    before do
      def view.signed_in_user?
        true
      end
      @user = user
      def view.current_user
        @user
      end
    end
    it "logout link is present" do
      secrets = create_list(:secret, num_secrets)
      assign(:secrets, secrets)
      render
      expect(rendered).to match('Logout')
    end
  end
end