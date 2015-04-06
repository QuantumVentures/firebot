include ActionDispatch::TestProcess

FactoryGirl.define do
  def fixtures_path(path)
    Rails.root.join("spec/fixtures").join(path).to_s
  end

  sequence(:email) { |n| "email-#{n}@example.com" }
  sequence(:name)  { |n| "name-#{n}" }
  sequence(:uid)   { |n| "uid-#{n}" }

  factory :backend_app do
    description { generate :name }
    name
    user
  end

  factory :feature do
    description { generate :name }
    loggable factory: :backend_app
    responsible factory: :user
  end

  factory :log do
    description { generate :name }
    loggable factory: :backend_app
    responsible factory: :user
  end

  factory :payment_method do
    liable factory: :user
    uid { generate :uid }
  end

  factory :user do
    email
    first_name { generate :name }
    last_name  { generate :name }
    password   { generate :uid }
  end
end
