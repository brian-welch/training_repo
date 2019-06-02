require 'json'
require 'open-uri'
require 'nokogiri'
require_relative 'seed_data/session_strategies.rb'
require_relative 'seed_data/exercise_bodyparts.rb'
require_relative 'seed_data/exercises.rb'
require_relative 'seed_data/users.rb'
require_relative 'seed_data/brands.rb'
require_relative 'seed_data/machines.rb'
require_relative 'seed_data/training_sessions.rb'
require_relative 'seed_data/session_sets.rb'


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
Brand.destroy_all
SessionSet.destroy_all
Machine.destroy_all
TrainingSession.destroy_all
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
  Gender.create!(name: gender.upcase)
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
    unilateral: exercise[:unilateral],
    machine: exercise[:machine],
    bodyweight: exercise[:bodyweight]
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
    gender: Gender.find_by_name(user[:gender].upcase),
    role: Role.find_by_name(user[:role])
    )
end

puts "\n#{User.count} Users created."
sleep 0.5

brand_list.each do |brand|
  Brand.create!(
    name: brand
    )
end

puts "\n#{Brand.count} Brands created."
sleep 0.5

machine_list.each do |machine|
  Machine.create!(
    brand: Brand.where(name: machine[:brand])[0],
    name: machine[:name],
    mech_ad: machine[:mech_ad],
    pulley_count: machine[:pulley_count]
    )
end

puts "\n#{Machine.count} Machines created."
sleep 0.5

users = ["Brian", "John"].each_with_object([]) {|user, arr| arr << User.find_by_first_name(user)}

  training_session_list.each do |sesh_details|
    new_t = TrainingSession.new(sesh_details)
    new_t.user_id = users[0].id
    new_t.save!
  end
  puts "\n#{TrainingSession.where(user: users[0]).count} Training Sessions created for #{users[0].first_name}."
  sleep 0.5

  count = 0
  session_set_list.each_with_index do |set_details_arr, index|
    tr = TrainingSession.where("session_number = ? AND user_id = ?", set_details_arr[0], users[0].id)[0]
    new_s = SessionSet.new(set_details_arr[1])
      new_s.training_session_id = tr.id
      new_s.created_at = tr.created_at + 1800 + index
      new_s.updated_at = tr.created_at + 1920 + index
      new_s.save!
      sleep 0.01
      count = index
  end

  puts "\n#{count} Sets created for #{users[0].first_name}."
  sleep 0.5

  (1..12).each do |x|
    t = TrainingSession.where("session_number = ?", x)[0]
    new_t = t.clone
    new_t.user_id = users[1].id
    new_t.save!
  end
  puts "\n#{TrainingSession.where(user: users[1]).count} Training Sessions created for #{users[1].first_name}."
  sleep 0.5

  count = 0
  (1..12).each_with_index do |x, i|
    sets_array = []
    session_set_list.each do |set_details_arr|
      sets_array << set_details_arr[1] if set_details_arr[0] == x
    end

    tr = TrainingSession.where("session_number = ? AND user_id = ?", x, users[1].id)[0]

    sets_array.each_with_index do |set_details, i|
      new_s = SessionSet.new(set_details)
      new_s.training_session_id = tr.id
      new_s.created_at = tr.created_at + 1800 + i
      new_s.updated_at = tr.created_at + 1920 + i
      new_s.save!
      sleep 0.01
      count = i
    end

  end
  puts "\n#{count} Sets created for #{users[1].first_name}."
  sleep 0.5




puts '- ' * 30 + "\n"
puts '*' * 23
puts ' Seeding Completed'
puts '*' * 23
