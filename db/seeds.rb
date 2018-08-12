rand(1..6).times do
	Forecast.create(
		city: Faker::Address.city,
		min_temp: [rand(20..30),rand(20..30),rand(20..30)],
		max_temp: [rand(15..25),rand(15..25),rand(15..25)],
		condition: Faker::Lorem.sentences(3),
		precipitation: [nil, rand(0..100), rand(0..100)],
		user_id: SecureRandom.urlsafe_base64
		)
end
rand(1..6).times do
	Forecast.create(
		city: Faker::Address.city,
		min_temp: [rand(20..30),rand(20..30),rand(20..30)],
		max_temp: [rand(15..25),rand(15..25),rand(15..25)],
		condition: Faker::Lorem.sentences(3),
		precipitation: [nil, rand(0..100), rand(0..100)],
		user_id: SecureRandom.urlsafe_base64
		)
end
rand(1..6).times do
	Forecast.create(
		city: Faker::Address.city,
		min_temp: [rand(20..30),rand(20..30),rand(20..30)],
		max_temp: [rand(15..25),rand(15..25),rand(15..25)],
		condition: Faker::Lorem.sentences(3),
		precipitation: [nil, rand(0..100), rand(0..100)],
		user_id: SecureRandom.urlsafe_base64
		)
end
rand(1..6).times do
	Forecast.create(
		city: Faker::Address.city,
		min_temp: [rand(20..30),rand(20..30),rand(20..30)],
		max_temp: [rand(15..25),rand(15..25),rand(15..25)],
		condition: Faker::Lorem.sentences(3),
		precipitation: [nil, rand(0..100), rand(0..100)],
		user_id: SecureRandom.urlsafe_base64
		)
end
