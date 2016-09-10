User.create(email: 'bobbysags@gmail.com', name: 'Bob Saget', password: '123')


20.times do 
	Event.create(
		title: Faker::Company.bs,
		description: Faker::Lorem.sentences(3),
		address: Faker::Address.street_address,
		event_date: Faker::Date.forward(23),
		event_time: Faker::Time.backward(14, :evening),
		price: Faker::Commerce.price
		)
end
