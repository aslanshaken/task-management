# app/controllers/api/tasks_controller.rb
class Api::TasksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy, :assign, :progress]
  before_action :set_task, only: [:show, :update, :destroy, :assign, :progress]

  def create
    # Post /api/tasks
    # {
    #   "task": {
    #     "title": "Complete Project Proposal",
    #     "description": "Draft the project proposal for client review.",
    #     "due_date": "2024-03-15"
    #   }
    # }

    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    # Put /api/tasks/{taskId}
    # {
    #   "task": {
    #     "description": "Finalize the project proposal for client review."
    #   }
    # }

    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # Delete /api/tasks/{taskId}

    @task.destroy
    head :no_content
  end

  def index
    # Get /api/tasks

    @tasks = Task.all
    render json: @tasks
  end

  def assign
    # Post /api/tasks/{taskId}/assign
    # user_id: id

    user_id = params[:user_id]
    user = User.find_by(id: user_id)

    if user.nil?
      render json: { error: "User not found" }, status: :not_found
      return
    end

    @task.user_id = user.id

    if @task.save
      render json: @task, status: :ok
    else
      render json: { error: "Failed to assign task" }, status: :unprocessable_entity
    end
  end

  # PUT /api/tasks/{taskId}/progress
  def progress
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status, :completed_date)
  end
end
