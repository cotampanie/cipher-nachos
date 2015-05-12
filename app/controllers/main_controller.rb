class MainController < ApplicationController

  def index
    if current_user
      redirect_to user_movies_path(current_user)
    end
  end

end