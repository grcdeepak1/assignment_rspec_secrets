require 'rails_helper'

describe UsersController do
  describe 'POST #create' do
    it 'creates a new user' do
      post :create, :user => attributes_for(:user)
      expect(response).to redirect_to user_path(assigns(:user))

      expect{
        post :create, user: attributes_for(:user)
      }.to change(User, :count).by(1)
    end

    it "create fails with wrong params" do
      post :create, :user => attributes_for(:user, :email => "")
      expect(response).to render_template :new

      expect{
        post :create, user: attributes_for(:user, :name => "a")
      }.to change(User, :count).by(0)
    end
  end

  describe 'PATCH #update' do
    let(:user){ create(:user) }
    let(:another_user){ create(:user) }
    let(:updated_name){ "new name" }
    before :each do
      session[:user_id] = user.id
    end

    context "with valid attributes" do
      before { user }
      it "actually updates the user" do
        put :update, :id => user.id,
                     :user => attributes_for(:user, :name => updated_name)
        user.reload
        expect(user.name).to eq(updated_name)
      end
    end

    context "failed to edit another user" do
      before { another_user }
      it "can't edit another user" do
        put :update, :id => another_user.id,
                      :user => attributes_for(:user, :name => updated_name)
        another_user.reload
        expect(another_user.name).not_to eq(updated_name)
      end
    end
  end

  describe 'GET #edit' do
    let(:user){ create(:user) }
    before { session[:user_id] = user.id }
    it 'edit sets the correct instance variable' do
      get :edit, :id => user.id
      expect(assigns(:user)).to eq(user)
    end
  end
end
