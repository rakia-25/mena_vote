class Candidate < ApplicationRecord
  scope :in_categories, ->(category_ids) {
    joins(:candidate_categories)
    .where(candidate_categories: { category_id: category_ids })
    .distinct
  }

  validates :vote_code, uniqueness: true

  belongs_to :year

  has_many :candidate_categories
  has_many :categories, through: :candidate_categories

end
