
get '/events' do

	@events = Event.all
  erb :'/events/index'
end


get '/events/:id' do
  @event = Event.find(params[:id])
  erb :'events/show'
end

post '/events' do
  @events = Event.where("price like ?", "%#{params[:price]}")
  p "*" * 100
  p params
  erb :'events/search'
end

post '/events1' do
  @events = Event.where("address like ?", "%#{params[:address]}")
  p "*" * 100
  p params
  erb :'events/search'
end

post '/events2' do
  @events = Event.where("event_time like ?", "%#{params[:event_time]}")
  p "*" * 100
  p params
  erb :'events/search'
end

post '/events3' do
  @events = Event.where("event_date like ?", "%#{params[:event_date]}")
  p "*" * 100
  p params
  erb :'events/search'
end

# get '/results' do
#   erb :'events/search'
# end

# post '/events/user' do
#   erb :'events/user'
# end
