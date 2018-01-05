class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:id])
  end

  def search
    query = params[:query]
    users = User.where('LOWER(username) LIKE ?', "#{query.downcase}%").pluck(:username)

    render json: users
  end
end
