# app/controllers/api/tasks_controller.rb
class Api::TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy, :assign, :progress]

  # POST /api/tasks
  def create
  end

  # PUT /api/tasks/{taskId}
  def update
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
end
