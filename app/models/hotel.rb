class Hotel < ApplicationRecord

	has_one_attached :image

	validates :name, presence: true, length: {minimum: 2, maximum: 125}
	validates :price_per_room, presence: true, length: {maximum: 12}
	validates :address, presence: true, length: {minimum:3, maximum: 400}

	def self.basic_search(param)
		param.strip!
	    to_send_back = (address_matches(param) + name_matches(param) + description_matches(param)).uniq
	    return nil unless to_send_back
	    to_send_back
	end

	def self.address_matches(param)
		self.matches('address', param)
	end

	def self.description_matches(param)
		self.matches('description', param)
	end

	def self.name_matches(param)
		self.matches('name', param)
	end

	def self.matches(field_name, param)
    	where("#{field_name} like ?", "%#{param}%")
  	end
end