# app/controllers/api/tasks_controller.rb
class Api::TasksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy, :assign, :progress, :overdue]
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

    tasks = Task.all
    priority_queue = ::TaskPriorityQueue.new(tasks)
    sorted_tasks = priority_queue.sorted_tasks
    render json: sorted_tasks
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

  def progress
    # Put /api/tasks/{taskId}/progress?progress=30

    progress = params[:progress].to_i
      if progress >= 0 && progress <= 100
        @task.progress = progress
        if @task.save
          render json: @task
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      else
        render json: { error: "Progress should be between 0 and 100" }, status: :unprocessable_entity
      end
  end

  def overdue
    # Get http://localhost:3000/api/tasks/overdue

    overdue_tasks = Task.where('due_date < ?', Time.now)
    render json: overdue_tasks
  end

  def by_status
    # Get http://localhost:3000/api/tasks/status/:status

    tasks = Task.where(status: params[:status])
    render json: tasks
  end

  def completed_within_range
    # Get http://localhost:3000/api/tasks/completed
    # {
    #   "startDate": "2024-01-20",
    #   "endDate": "2024-05-05"
    # }

    start_date = Date.parse(params[:startDate])
    end_date = Date.parse(params[:endDate])
    byebug
    completed_tasks = Task.where(completed_date: start_date..end_date)
                            .where.not(completed_date: nil)
    render json: completed_tasks
  end

  def statistics
    # Get http://localhost:3000/api/tasks/statistics

    total_tasks = Task.count
    completed_tasks = Task.where.not(completed_date: nil).count
    percentage_completed = (completed_tasks.to_f / total_tasks * 100).round(2)
    
    render json: {
      total_tasks: total_tasks,
      completed_tasks: completed_tasks,
      percentage_completed: percentage_completed
    }
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status, :completed_date)
  end
end
