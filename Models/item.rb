require 'json'

class Item
	attr_accessor :id, :sku, :description, :price, :stock

	def initialize(new_id, new_sku, new_description, new_price, new_stock)
		#super(new_id, new_sku)
		@id = new_id
		@sku = new_sku
		@description = new_description
		@price = new_price
		@stock = new_stock
	end

	def to_short_hash
		{"id": "#{@id.to_s}", "sku": "#{@sku.to_s}", "description": "#{@description.to_s}"}
	end

	def to_long_hash
		{"id": "#{@id.to_s}", "sku": "#{@sku.to_s}", "description": "#{@description.to_s}", "price": "#{@price.to_s}", "stock": "#{@stock.to_s}"}
	end

	def update_feature(feature_key, feature_value)
		instance_variable_set("@#{feature_key}",feature_value)
	end

end