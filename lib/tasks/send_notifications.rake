namespace :cipher_nachos do

  task send_notifications: :environment do

    Notification.all.each do |notification|
      movies = Itunes::Movie.search notification.term
      unless movies.empty?
        notification.users.each do |user|
          NotificationMailer.notification_email(user, notification, movies).deliver
        end
        notification.destroy
      end
    end
  end
end