class Booking < ApplicationRecord
	belongs_to :user
	belongs_to :hotel

	validates :from_date, presence: true
	validates :to_date, presence: true

	def to_date_after_from_date
		return if to_date.blank? || from_date.blank?

		if to_date < from_date
			errors.add(:to_date, "Must be after the from date")
		end
	end
end