# db/seeds.rb
require 'faker'

Assignment.destroy_all
Task.destroy_all
User.destroy_all

5.times do
  User.create( name: Faker::Name.name, email: Faker::Internet.email)
end

10.times do
  Task.create(title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    due_date: Faker::Time.forward(days: 30),
    status: ['Pending', 'In Progress', 'Completed'].sample,
    priority: ['High', 'Medium', 'Low'].sample
  )
end

Task.all.each do |task|
  user = User.offset(rand(User.count)).first
  Assignment.create(task_id: task.id, user_id: user.id)
end
