require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'should login user when password is correct' do
      user = create(:user)

      post :create, email: user.email, password: user.password

      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to(root_path(user.id))
    end

    it 'should display login form when password is incorrect' do
      user = create(:user)

      post :create, email: user.email, password: 'wrong_password'

      expect(response).to render_template('new')
    end
  end

  describe 'DELETE #destroy' do
    it 'should logout user' do
      session[:user_id] = 1

      delete :destroy

      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(log_in_path)
    end
  end

end
