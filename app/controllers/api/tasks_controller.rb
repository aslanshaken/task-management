# app/controllers/api/tasks_controller.rb
class Api::TasksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update]
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

  # DELETE /api/tasks/{taskId}
  def destroy
  end

  # POST /api/tasks/{taskId}/assign
  def assign
  end

  # PUT /api/tasks/{taskId}/progress
  def progress
  end

  # GET /api/tasks
  def index
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status, :completed_date)
  end
end
