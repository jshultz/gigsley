require 'faker'

namespace :db do
  desc "Create users"
  task fake_users: :environment do
    12.times do |n|
      puts "[DEBUG] creating user #{n+1} of 12"
      fullname = Faker::Name.name
      email = "user-#{n+1}@example.com"
      password = "password"
      image = Faker::Avatar.image
      User.create!( fullname: fullname,
                    email: email,
                    image: image,
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
    User.last(6).reverse.each do |user|

      temp_user = User.where :id => user.id
      if temp_user.present? && temp_user.first.profile.blank?
        full_address = address[count]
        parsed_address = full_address.split(/\s*,\s*/)

        1.times do |n|
        puts "[DEBUG] creating activity #{count} of ~6"
        Profile.create!(
                      street: parsed_address[0],
                      city: parsed_address[1],
                      state: parsed_address[2],
                      mobile_phone: Faker::PhoneNumber.cell_phone,
                      full_address: address.sample,
                      user_id: user.id,
                      job_id: [1,2].sample,
                      skill_list: ['hugger', 'detail orientated', 'outoing', 'playful'].sample,
                      provider: 1,
                      customer: 0,
                      terms: 1

        )
        end # 6.times
      end # user.present?
    count+=1
    end # User.each
    count = 0
    User.take(6).each do |user|
      temp_user = User.where :id => user.id
      if temp_user.present? && temp_user.first.profile.blank?
        full_address = address[count]
        parsed_address = full_address.split(/\s*,\s*/)

        1.times do |n|
          puts "[DEBUG] creating activity #{count} of ~6"
          profile = Profile.create!(
                      street: parsed_address[0],
                      city: parsed_address[1],
                      state: parsed_address[2],
                      mobile_phone: Faker::PhoneNumber.cell_phone,
                      full_address: address.sample,
                      user_id: user.id,
                      job_id: [1,2].sample,
                      provider: 0,
                      customer: 1,
                      terms: 1

                  )
          Gig.create!(
                 profile_id: profile.id,
                 jobName: Faker::Name.title,
                 description: Faker::Name.title,
                 job_id: [1,2].sample
          )
        end # 6.times
      end # user.present?
      count+=1
    end
  end # fake_Activities

end