require 'rails_helper'

describe "secrets/index.html.erb" do
  let(:num_secrets) { 3 }
  let( :user ){ create( :user ) }
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
    it "non-logged in User cannot see secret's author" do
      secrets = create_list(:secret, num_secrets)
      assign(:secrets, secrets)
      render
      expect(rendered).to match('<td>\*\*hidden\*\*</td>')
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
    it "logged in User can see secret's author" do
      secrets = create_list(:secret, num_secrets)
      assign(:secrets, secrets)
      render
      expect(rendered).to match('<td>Foo Bar')
    end
  end
end