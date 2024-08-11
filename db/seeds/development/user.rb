# frozen_string_literal: true

today = Time.zone.today
10.times do |i|
  User.create!(
    name: "user name #{i}",
    email: "user#{i}@example.com",
    birthday: today + i.days,
  )
end
