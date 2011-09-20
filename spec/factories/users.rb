# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
      name "MyString"
      address_line_1 "MyString"
      address_line_2 "MyString"
      city "MyString"
      state "MyString"
      zipcode "MyString"
      phone_number "MyString"
    end
end