FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:name){|n| "Foo Bar#{n}" }
    email          { "#{name}@email.com" }
    password       "foobar123"
  end
  factory :secret do
    title "Foo Title"
    body  "Foo Body"
    author
  end
end