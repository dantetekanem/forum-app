class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.recent
  end
  def show
    notification = current_user.notifications.find(params[:id])

    notification.read! unless notification.readed?
    redirect_to notification.visit_path
  end
end
