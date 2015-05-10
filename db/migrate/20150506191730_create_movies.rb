class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :track_id
      t.integer :user_id

      t.timestamps
    end
  end
end
