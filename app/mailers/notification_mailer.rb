class NotificationMailer < ActionMailer::Base
  default from: 'cotampanie@gmail.com'

  def notification_email(user, notification, movies)
    @user = user
    @notification = notification
    @movies = movies
    mail(to: @user.email, subject: "We found movies for term: #{@notification.term}")
  end
end
