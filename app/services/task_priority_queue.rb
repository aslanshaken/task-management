class TaskPriorityQueue
  PRIORITY_MAPPING = { 'High' => 3, 'Medium' => 2, 'Low' => 1 }.freeze

  def initialize(tasks)
    @tasks = tasks
  end

  def sorted_tasks
    @tasks.sort_by { |task| [task.due_date, priority_value(task.priority)] }
  end

  private

  def priority_value(priority)
    PRIORITY_MAPPING[priority] || 0
  end
end
