require 'sinatra'
require 'json'
require_relative '../Controllers/minimarket_controller'

minimarket = MinimarketLLCController.new
#minimarket.new_item({"sku"=>215,"description"=>'Harina 000', "stock"=>10,"price"=>12.5})
#minimarket.new_item({"sku"=>211, "description"=>'Polenta', "stock"=>50,"price"=>21.5})

before do
	content_type :json
end

get '/items.json' do
	all_items = minimarket.all_items
	status 200
	all_items.to_json
end

get '/items/:id.json' do |id|
	a = minimarket.item(id) 
	a[:error].nil? ? (status 200) : (status 404)
	a.to_json
end

post '/items.json' do 
	status 422
	data = JSON.parse(request.body.read).slice('sku', 'description', 'stock', 'price')
	if(data.size == 4)
		item = minimarket.new_item(data)
		(status 201) if item[:message].nil?
		item.to_json
	else
		{"message": "No se recibieron todos los parametros"}.to_json
	end
end

put '/items/:id.json' do | id |
	status 422
	data = JSON.parse(request.body.read).slice('sku', 'description', 'stock', 'price')
	#Se valida que se haya pasado al menos un parametro
	if(data.size >= 1)
		item = minimarket.update_item(id,data)
		(status 200) if item[:message].nil?
		item.to_json
	else
		{"message": "No se recibieron todos los parametros"}.to_json
	end
end

get '/cart/:username.json' do | username |
	status 200
	(minimarket.user_shopping_cart(username)).to_json
end

put '/cart/:username.json' do |username|
	status 422
	data = JSON.parse(request.body.read).slice('id', 'amount')
	if (data.size == 2)
		shopping_cart = minimarket.add_item_to_shopping_cart(username,data)
		(status 200) if shopping_cart[:message].nil?
		shopping_cart.to_json
	else
		{"message": "No se recibieron todos los parametros"}.to_json
	end
end

delete '/cart/:username/:item_id.json' do |username,item_id|
	status 202
	minimarket.delete_item_from_shopping_cart(username,item_id).to_json
end


##Variable PARAMS recibe el body del request
##usar status: codigo
##devolver json como ultima linea del cuerpo que procesa el request