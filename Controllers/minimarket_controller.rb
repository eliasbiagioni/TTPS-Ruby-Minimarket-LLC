require_relative '../Models/shopping_cart'
require_relative '../Models/item'

class MinimarketLLCController
	attr_accessor :items, :shopping_carts, :id_item

	def initialize
		@id_item = 1
		@items = Hash.new
		@shopping_carts = Hash.new { |hash, key| hash[key] = ShoppingCart.new }
	end

	def all_items()
		#Retorna una hash con todos los items, donde la clave es el id del item y el valor es el item en formato Hash
		all_items = Hash.new
		@items.each { |item| all_items[item[1].id] = item[1].to_short_hash}
		all_items
	end

	def new_item(data)
		if (@items.detect {|item| item[1].sku == data['sku']}).nil?
			@items[@id_item] = Item.new(@id_item, data['sku'], data['description'], data['price'], data['stock'])
			@id_item += 1
			@items.values.last.to_long_hash
		else
			{"message": "El item con dicho sku ya existe"}
		end
	end

	def update_item(id,data)
		item = @items[id.to_i]
		if(item.nil?)
			{"message": "No se encontró el ítem"}
		else
			data.each do | feature |
				item.update_feature(feature[0],feature[1])
			end
			item.to_long_hash
		end
	end	

	def add_item_to_shopping_cart(username, data)
		if @shopping_carts[username].add_item(@items[data['id']], data['cantidad']) 
			@items[data['id']].stock -=  data['cantidad'] 
			@shopping_carts[username].json_shopping_cart
		else
			{"message": "No se pudo agregar el item porque la cantidad especificada supera el stock"}
		end
	end

	def user_shopping_cart(user)
		@shopping_carts[user].json_shopping_cart
	end

	def item(id)
		item = @items.detect { | item | item[1].id == id.to_i}
		item.nil? ? {"error": "No se encuentra item con ese id"} : item[1].to_long_hash
	end

end