class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:tasks]

  def tasks
    # Get http://localhost:3000/api/users/{userId}/tasks

    user = User.find(params[:user_id])
    tasks = user.tasks
    render json: tasks
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end
end
