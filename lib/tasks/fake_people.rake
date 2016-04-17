require 'faker'

namespace :db do
  desc "Create users"
  task fake_users: :environment do
    6.times do |n|
      puts "[DEBUG] creating user #{n+1} of 6"
      fullname = Faker::Name.name
      email = "user-#{n+1}@example.com"
      password = "password"
      User.create!( fullname: fullname,
                    email: email,
                    password: password,
                    password_confirmation: password)
    end
  end

  task fake_profiles: :environment do
    count = 0
    address = []
    address[0] = '222 S Main ST, Salt Lake City, UT 84101'
    address[1] = '175 200 South, Salt Lake City, UT 84101'
    address[2] = '3003 Thanksgiving Way, Lehi, UT 84043'
    address[3] = '3740 13400 S, Riverton, UT 84065'
    address[4] = '231 400 South, Salt Lake City, UT 84111'
    address[5] = '4315 South 2700 West, Salt Lake City, UT 84184'
    User.all.each do |user|

      temp_user = User.where :id => user.id
      if temp_user.present? && temp_user.first.profile.blank?
        full_address = address[count]
        parsed_address = full_address.split(/\s*,\s*/)

        1.times do |n|
        puts "[DEBUG] creating activity #{n+1} of ~6"
        Profile.create!(
                      street: parsed_address[0],
                      city: parsed_address[1],
                      state: parsed_address[2],
                      mobile_phone: Faker::PhoneNumber.cell_phone,
                      full_address: address.sample,
                      user_id: user.id
        )
        end # 5.times
      end # user.present?
    count+=1
    end # User.each
  end # fake_Activities

end