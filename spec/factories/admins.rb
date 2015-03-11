require 'faker'

FactoryGirl.define do
  
  password = Faker::Internet.password(10)

  factory :admin do
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }

  end
end
