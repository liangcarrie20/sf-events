require 'open-uri'
require 'nokogiri'

User.create(email: 'bobbysags@gmail.com', name: 'Bob Saget', password: '123')


# 20.times do
# 	Event.create(
# 		title: Faker::Company.bs,
# 		description: Faker::Lorem.sentences(3),
# 		address: Faker::Address.street_address,
# 		event_date: Faker::Date.forward(23),
# 		event_time: Faker::Time.backward(14, :evening),
# 		price: Faker::Commerce.price
# 		)
# end


 WHITE_SPACE_BETWEEN_TAGS = /(?<=>)\s+(?=<)/
  doc = open('http://sf.funcheap.com/events/', &:read).gsub(/\s+/, ' ')
  refined_doc = doc.gsub(WHITE_SPACE_BETWEEN_TAGS, '')
  nokogiri_doc = Nokogiri.parse(refined_doc)

 @date = nokogiri_doc.css('tr')[1].text
  times_table = nokogiri_doc.css('tr')[2..-1]
  times_table.each do |t|
    @time = t.children.first.text.squish
    @price = t.children.last.text.squish
    t.css('td a').each do |a|
      if (a.to_a[2] != nil) && (a.to_a[0][1] != nil)
        @website = a.to_a[0][1]
        @title =  a.to_a[2][1].split("|")[0]
        @neighborhood = a.to_a[2][1].split("|")[1]
      end
    end
   Event.create(title: @title, event_time: @time, price: @price, address: @neighborhood, event_date: @date, description: @website)
  end
