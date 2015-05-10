require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  MOVIE_ID = 1
  
  before(:each) do
    @user = create(:user)
    session[:user_id] = @user.id
  end

  describe 'GET #index' do

    it 'should return watchlist' do
      stub_api_for(Itunes::Movie) do |stub|
        stub.get("/lookup?id=#{MOVIE_ID}") { |env| [200, {}, [{ track_id: 1, trackName: 'Avengers'}].to_json] }
      end

      expect_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      expect(@user).to receive(:movies).and_return([Movie.new(track_id: MOVIE_ID)])

      get :index, {user_id: @user.id}
      expect(response).to have_http_status(:success)
    end

    it 'should redirect to login page when not sign in' do
      session[:user_id] = nil
      get :index, {user_id: @user.id}
      expect(response).to redirect_to(new_session_path)
    end

  end

  describe 'GET #search' do

    it 'should invoke search when term is specified' do
      TERM = 'Avengers'
      expect(Itunes::Movie).to receive(:search).with(TERM).once.and_return []

      xhr :get, :search, term: TERM

      expect(response).to have_http_status(:success)
    end

    it 'should not invoke search when term is not specified' do
      expect(Itunes::Movie).not_to receive(:search)

      xhr :get, :search

      expect(response).to have_http_status(:success)
    end

  end

  describe 'POST #create' do

    it 'should assign movie to the user' do
      movies = double('Array')
      expect(movies).to receive(:<<).once.and_return(true)
      expect_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      expect(@user).to receive(:movies).and_return(movies)

      xhr :post, :create, user_id: @user.id, track_id: MOVIE_ID

      expect(response).to have_http_status(:success)
    end

  end

  describe 'DELETE #destroy' do

    it 'should unassign movie from the user' do
      movie = double('Movie', track_id: MOVIE_ID)
      expect(Movie).to receive(:find_by).with(track_id: "#{MOVIE_ID}").and_return(movie)
      expect(movie).to receive(:destroy).and_return(true)

      xhr :delete, :destroy, user_id: @user.id, id: MOVIE_ID

      expect(response).to have_http_status(:success)
    end

  end

end
