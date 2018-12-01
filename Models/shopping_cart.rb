require_relative 'item'

class ShoppingCart
	attr_accessor :items, :username, :date

	def initialize()
		@items = Hash.new
		@date = Date.today
	end

	def add_item(item, amount)
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
		json_items = @items.map { |key,value| [value[0].id, value[0].to_long_hash]}.to_h
		{"items": json_items, "total_price": total_price, "date": @date}
	end

	def total_price
		@items.inject(0) { |sum, (key,value)| sum + (value[0].price*value[1]) } 
	end
end
