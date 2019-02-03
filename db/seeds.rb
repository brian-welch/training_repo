require 'json'
require 'open-uri'
require 'nokogiri'
require_relative 'seed_data/session_strategies.rb'
require_relative 'seed_data/exercise_bodyparts.rb'
require_relative 'seed_data/exercises.rb'
require_relative 'seed_data/users.rb'


## clears terminal window
system 'clear'

## adds arty farty title to terminal
puts '*' * 23
puts ' Seeding your database'
puts '*' * 23
puts '- ' * 30 + "\n"


puts "\nDestroying the database!!"
sleep 0.5

ExerciseBodypart.destroy_all
SessionExercise.destroy_all
Session.destroy_all
SessionStrategy.destroy_all
Bodypart.destroy_all
Exercise.destroy_all
User.destroy_all
Gender.destroy_all
Role.destroy_all

puts "\nDatabase destroyed."
puts '- ' * 30 + "\n"

puts "\nPopulating database."
puts '- ' * 30 + "\n"


role_list = %w(admin manager pt user)
role_list.each do |role|
  Role.create!(name: role)
end

puts "\n#{Role.count} Roles created."
sleep 0.5

gender_list = %w(m f)
gender_list.each do |gender|
  Gender.create!(name: gender)
end

puts "\n#{Gender.count} Genders created....  because there are only 2!"
sleep 0.5

bodypart_list = ["Gastrocs", "Soleus", "Quads", "Hamstrings", "Adductors", "Abductors", "Hip Flexors", "Glutes", "Lower Back", "Abs", "Obliques", "Lats", "Traps", "Rear Delts", "Delts", "Front Delts", "Rotator Cuff", "Triceps", "Biceps", "Forearms", "Pecs", "Neck Flexors"]
bodypart_list.each do |bodypart|
  Bodypart.create!(name: bodypart)
end

puts "\n#{Bodypart.count} Bodyparts created."
sleep 0.5

strategy_list.each do |strategy|
  SessionStrategy.create!(
    name: strategy[:name],
    description:  strategy[:description]
    )
end

puts "\n#{SessionStrategy.count} Session Strategies created."
sleep 0.5



exercise_list.each do |exercise|
  Exercise.create!(
    name: exercise[:name],
    unilateral:  exercise[:unilateral]
    )
end

puts "\n#{Exercise.count} Exercises created."
sleep 0.5



exercise_bodyparts_list.each do |ex_body|
  ex_body[:bodyparts].each do |bodypart|
    ExerciseBodypart.create!(
      exercise: Exercise.find_by_name(ex_body[:name]),
      bodypart: Bodypart.find_by_name(bodypart)
      )
  end
end

puts "\n#{ExerciseBodypart.count} Exercise Bodyparts created."
sleep 0.5



user_list.each do |user|
  User.create!(
    first_name: user[:first_name],
    last_name: user[:last_name],
    email: user[:email],
    password: user[:password],
    birthdate: DateTime.strptime(user[:birthdate], "%Y/%m/%d"),
    weight: user[:weight],
    active: user[:active],
    gender: Gender.find_by_name(user[:gender]),
    role: Role.find_by_name(user[:role])
    )
end

puts "\n#{User.count} Users created."
sleep 0.5



puts '- ' * 30 + "\n"
puts '*' * 23
puts ' Seeding Completed'
puts '*' * 23
