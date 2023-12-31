# frozen_string_literal: true

FactoryBot.define do
  factory :paper_submisison do
  end

  factory :paper_element do
  end

  factory :paper do
  end

  factory :course do
  end

  factory :user do
    sequence(:name) { |n| "John Doe #{n}" }
    sequence(:email) { |n| "test#{n}@example" }
    sequence(:phone) { |n| "123456789#{n}" }
    sequence(:password) { |n| "password#{n}" }
  end
end
