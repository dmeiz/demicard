FactoryGirl.define do
  factory :user do
    omniauth_provider 'twitter'
    sequence(:omniauth_uid)
  end
end
