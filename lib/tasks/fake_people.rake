require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task fake_students: :environment do
    20.times do |n|
      puts "[DEBUG] creating user #{n+1} of 20"
      fullname = Faker::Name.name
      email = "students-#{n+1}@example.com"
      student = '1'
      password = "password"
      User.create!( fullname: fullname,
                    email: email,
                    student: student,
                    password: password,
                    password_confirmation: password)
    end
  end

  task fake_teachers: :environment do
    20.times do |n|
      puts "[DEBUG] creating user #{n+1} of 20"
      fullname = Faker::Name.name
      email = "teachers-#{n+1}@example.com"
      teacher = '1'
      password = "password"
      User.create!( fullname: fullname,
                    email: email,
                    teacher: teacher,
                    password: password,
                    password_confirmation: password)
    end
  end

  task fake_parents: :environment do
    20.times do |n|
      puts "[DEBUG] creating user #{n+1} of 20"
      fullname = Faker::Name.name
      email = "parents-#{n+1}@example.com"
      parent = '1'
      password = "password"
      User.create!( fullname: fullname,
                    email: email,
                    parent: parent,
                    password: password,
                    password_confirmation: password)
    end
  end

  task fake_activities: :environment do
    address = []
    address[0] = '222 S Main ST, Salt Lake City, UT 84101'
    address[1] = '175 200 South, Salt Lake City, UT 84101'
    address[2] = '3003 Thanksgiving Way, Lehi, UT 84043'
    address[3] = '3740 13400 S, Riverton, UT 84065'
    address[4] = '231 400 South, Salt Lake City, UT 84111'
    address[5] = '4315 South 2700 West, Salt Lake City, UT 84184'

    User.all.each do |user|
      teacher = Teacher.where :user_id => user.id
      if teacher.present?
        teacher = Teacher.where :user_id => user.id
        5.times do |n|
        puts "[DEBUG] creating activity #{n+1} of 20"
        name = Faker::Company.catch_phrase
        datestart = Time.now.utc + rand(20)
        dateend = datestart + 10*60*20
        description = Faker::Lorem.paragraph(3)
        parent = '1'
        Activity.create!( name: name,
                      start: datestart,
                      end: dateend,
                      location: address.sample,
                      description: description,
                      permission_slip: [0, 1].sample,
                      teacher_id: teacher.first.id)
        end # 5.times
      end # user.present?

    end # User.each
  end # fake_Activities

end