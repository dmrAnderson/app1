User.create(name: 'Artem', email: 'hell61@ukr.net', password: 'gggggg', admin: 'true', activated: 'true')

49.times do
	User.create(
		name: Faker::Name.name,
		email: Faker::Internet.email,
		password: 'password',
		activated: 'true'
	)
end
