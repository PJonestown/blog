FactoryGirl.define do
  factory :commenter do

    email "test@email.com"
    password "password"
    password_confirmation "password"
    name "kubric"

    factory :other_commenter do
      email "other@email.com"
      name "Stanley"
    end
  end

end
