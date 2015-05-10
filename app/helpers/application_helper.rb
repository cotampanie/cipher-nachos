module ApplicationHelper

  def in_watchlist?(track_id)
    current_user_movies.find{|movie| movie.track_id == track_id}
  end

end
