class Movie < ActiveRecord::Base

  validates :user_id, presence: true
  validates :track_id, presence: true

  belongs_to :user
end
