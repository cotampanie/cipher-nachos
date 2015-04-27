class MoviesController < ApplicationController
  before_action :authenticate!

  def index
    if params[:term]
      uri = URI('https://itunes.apple.com/search?entity=movie&term='+params[:term])
      resp_json = Net::HTTP.get(uri)
      resp = JSON.parse resp_json
      @count = resp['resultCount']
      @results = resp['results']
    end
  end

end
