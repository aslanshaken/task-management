class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.string :status
      t.datetime :completed_date
      t.string :priority

      t.timestamps
    end
  end
end
