class CandidateCategory < ApplicationRecord
  belongs_to :candidate
  belongs_to :category
end
