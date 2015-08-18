require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'foods'
)

get '/' do
  {:message => 'Not allowed. Please try "/api/foods"'}.to_json
end

### RESTful api

def food_id
  food_params = { :id => params[:id] }
end

def food_object
  food_params = { :name => params[:name], :calories => params[:calories] }
end

def food_update_object
  food_params = {
    :id => params[:id],
    :name => params[:name],
    :calories => params[:calories]
  }
end

### Get (all)
get '/api/foods' do
  Food.all.to_json
end

### Get (by id)

get '/api/foods/:id' do
  Food.find(food_id[:id]).to_json
end

### CREATE

post '/api/foods' do
  Food.create(food_object).to_json
end

### UPDATE (by id)
put '/api/foods/:id' do
  @food = Food.find(food_update_object[:id])
  @food.name = food_update_object[:name]
  @food.calories = food_update_object[:calories]
  @food.save
  @food.to_json
end

patch '/api/foods/:id' do
  @food = Food.find(food_update_object[:id])
  @food.name = food_update_object[:name]
  @food.calories = food_update_object[:calories]
  @food.save
  @food.to_json
end

### DELETE (by id)
delete '/api/foods/:id' do
  Food.destroy(food_id[:id])
end

### end RESTFul api
