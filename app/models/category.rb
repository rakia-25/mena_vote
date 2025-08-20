class Category < ApplicationRecord
  has_many :candidate_categories
  has_many :candidates, through: :candidate_categories
end
