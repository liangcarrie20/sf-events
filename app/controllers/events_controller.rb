
get '/events' do

	@events = Event.all
  erb :'/events/index'
end


get '/events/:id' do
  @event = Event.find(params[:id])
  erb :'events/show'
end


get '/events/user' do
  erb :'events/search'
end


# post '/events/user' do
#   erb :'events/user'
# end
