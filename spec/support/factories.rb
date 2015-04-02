include ActionDispatch::TestProcess

FactoryGirl.define do
  def fixtures_path(path)
    Rails.root.join("spec/fixtures").join(path).to_s
  end

  sequence(:email) { |n| "email-#{n}@example.com" }
  sequence(:first_name)  { |n| "name-#{n}" }
  sequence(:last_name)  { |n| "name-#{n}" }
  sequence(:uid)   { |n| "uid-#{n}" }

  factory :user do
    email
    first_name
    last_name
    password { SecureRandom.uuid }
  end
end
