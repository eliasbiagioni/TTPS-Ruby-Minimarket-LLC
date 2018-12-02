require_relative 'item'

class ShoppingCart
	attr_accessor :items, :username, :date

	def initialize()
		@items = Hash.new
		@date = Date.today
	end

	def add_item(item, amount)
		#Agrega un item al carrito.
		#Si el item ya existe y el stock es suficiente, se aumenta la cantidad del item en el carrito.
		item_in_cart = @items["#{item.id}"]
		if (!item_in_cart.nil?) and ((item.stock - amount) >= 0)
			@items["#{item.id}"][1] += amount
			true
		elsif ((item.stock - amount) >= 0)
			@items["#{item.id}"] = [item,amount]
			true
		else
			false
		end
	end

	def json_shopping_cart
		#Retorna el contexto del carrito en formato Hash
		json_items = @items.map { |key,value| [value[0].id, value[0].to_long_hash]}.to_h
		{"items": json_items, "total_price": total_price, "date": @date}
	end

	def total_price
		#Calcula el precio total del carrito
		@items.inject(0) { |sum, (key,value)| sum + (value[0].price*value[1]) } 
	end

	def has_item(item_id)
		!@items[item_id].nil?
	end

	def delete_item(item_id)
		#Elimina un item del carrito y retorna la cantidad que se habia reservado para que el stock del item se actualice.
		amount = @items[item_id][1]
		@items.delete(item_id)
		amount
	end
end
