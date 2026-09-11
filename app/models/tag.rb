class Tag < ApplicationRecord
	has_many :post_tags, dependent: :destroy
	has_many :posts, through: :post_tags

	def self.find_or_create_list(value)
		value.to_s.split(",").filter_map do |name|
			normalized_name = name.strip
			find_or_create_by!(name: normalized_name) if normalized_name.present?
		end
	end
end
