FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "foo#{n}" }
    email           "foo@bar.com"
  end
  factory :secret do
    title "Foo Title"
    body  "Foo Body"
    user
  end
end