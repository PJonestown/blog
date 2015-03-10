FactoryGirl.define do
  password = Faker::Internet.password(10)

  factory :admin do
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }

    after(:build) do |admin|
      admin.posts << build(:phone)
    end
  end

  factory :invalid_admin do
    email nil
  end

end
