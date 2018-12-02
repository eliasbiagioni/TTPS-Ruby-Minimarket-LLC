require 'json'

class Item
	attr_accessor :id, :sku, :description, :price, :stock

	def initialize(new_id, new_sku, new_description, new_price, new_stock)
		@id = new_id
		@sku = new_sku
		@description = new_description
		@price = new_price
		@stock = new_stock
	end

	def to_short_hash
		#Retorna una parte del contexto del item en formato Hash
		{"id": "#{@id.to_s}", "sku": "#{@sku.to_s}", "description": "#{@description.to_s}"}
	end

	def to_long_hash
		#Retorna el contexto completo del item en formato Hash
		{"id": "#{@id.to_s}", "sku": "#{@sku.to_s}", "description": "#{@description.to_s}", "price": "#{@price.to_s}", "stock": "#{@stock.to_s}"}
	end

	def update_feature(feature_key, feature_value)
		#Actualiza una caracteristica del item (feature_key) con el valor de feature_value
		instance_variable_set("@#{feature_key}",feature_value)
	end

end