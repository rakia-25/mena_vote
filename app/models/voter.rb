class Voter < ApplicationRecord
  belongs_to :candidate, optional: true
  belongs_to :payment, optional: true
end
