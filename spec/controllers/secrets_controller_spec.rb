require 'rails_helper'

describe SecretsController do
  describe 'GET #show' do
    it 'assigns correct instance variable' do
      secret = create(:secret)
      get :show, :id => secret.id
      expect(assigns(:secret)).to eq(secret)

    end

    it "renders the :show template" do
      secret = create(:secret)
      get :show, :id => secret.id
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    let(:user){ create(:user) }
    context "logged in users" do
      before { session[:user_id] = user.id }
      it 'logged in user can create a secret' do
        post :create, :secret => attributes_for(:secret)
        expect(response).to redirect_to secret_path(assigns(:secret))
        expect{
          post :create, secret: attributes_for(:secret)
        }.to change(Secret, :count).by(1)
      end

      it 'successfully created secret displays flash message' do
        post :create, :secret => attributes_for(:secret)
        expect(session[:flash]["flashes"]["notice"]).to eq('Secret was successfully created.')
      end
    end

    it 'logged out user cannot create a secret' do
      post :create, :secret => attributes_for(:secret)
      expect{
        post :create, secret: attributes_for(:secret)
      }.to change(Secret, :count).by(0)
    end
  end

  describe 'GET #edit' do
    let(:user){ create(:user) }
    before { session[:user_id] = user.id }
    it 'edit sets the correct instance variable' do
      secret = create(:secret, author_id: user.id)
      get :edit, :id => secret.id
      expect(assigns(:secret)).to eq(secret)
    end
  end
end