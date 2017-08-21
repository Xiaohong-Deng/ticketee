FactoryGirl.define do
  factory :user do
    # sequence behaves like this
    # in the first scenario, call user 10 times in a row
    # returns 10 same objects in a row, e.g. test1@example.com
    # in the second scenario, call user 10 time in a row
    # returns 10 same objects in a row, e.g. test2@example.com
    sequence(:email) { |n| "test#{n}@example.com" }
    password "password"

    trait :admin do
      admin true
    end
  end
end
