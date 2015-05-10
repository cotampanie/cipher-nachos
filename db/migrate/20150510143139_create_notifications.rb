class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :term
      t.timestamps
    end

    create_table :notifications_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :notification, index: true
    end
  end
end
