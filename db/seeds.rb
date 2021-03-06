# frozen_string_literal: true

User.create(
  name: 'Artem',
  email: 'hell61@ukr.net',
  password: 'gggggg',
  admin: 'true',
  activated: 'truew'
)

19.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    activated: 'true'
  )
end

12.times do
  users = User.order(:created_at).take(6)
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.posts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
