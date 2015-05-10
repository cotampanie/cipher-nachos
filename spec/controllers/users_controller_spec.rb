require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'should create new user for proper data' do
      user = build(:user)
      post :create, user:{ email: user.email, name: user.name, password: user.password }

      expect(assigns(:user)).not_to be_nil
      expect(session[:user_id]).to eq(assigns(:user).id)
      expect(response).to redirect_to(root_path(assigns(:user).id))
    end

    it 'should render new form where data are not correct' do
      user = build(:user)
      post :create, user:{ email: user.email, name: user.name, password: nil }
      expect(response).to render_template('new')
    end

  end

end
