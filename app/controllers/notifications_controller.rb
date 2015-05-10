class NotificationsController < ApplicationController
  before_action :authenticate!

  def index
    @notifications = current_user.notifications
  end

  def create
    if params[:term]
      unless current_user.notifications.find_by(term: params[:term])
        notification = Notification.find_by(term: params[:term])
        notification = Notification.new term: params[:term] unless notification

        current_user.notifications << notification
      end

      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    notification = Notification.find(params[:id])
    current_user.notifications.delete notification

    redirect_to user_notifications_path(current_user)
  end
end