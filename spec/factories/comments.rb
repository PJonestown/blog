FactoryGirl.define do
  factory :comment do
    body "MyText"
    association :post
    owner_type "Commenter"
    owner_id 1
  end

end
