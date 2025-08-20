class Inscription < ApplicationRecord
  include SoftDeletable

  belongs_to :region
  belongs_to :year

  has_many :payments

  has_one_attached :photo
  enum status: { init: 0, accepted: 1, rejected: 2}
  enum studying_level: { bac: 0, bts: 1, licence: 2, master: 3, doctorat: 4 }
  enum age: { eigtheen: 0, nigtheen: 1, twenty: 2, twenty_one: 3, twenty_two: 4, twenty_three: 5, twenty_four:6, twenty_five: 7, twenty_six: 8, twenty_seven: 9 }

  validates  :first_name, :photo, :last_name, :phone_whatsapps, :age, :height, :region_id, :weigth, :email, presence: true
  validates  :payment_phone, presence: true, if: Proc.new { |i| i.inscription_fee }

  validates :phone_whatsapps, phone: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :height, numericality: { greater_than_or_equal_to: 68, less_than_or_equal_to: 99  }

  jsonb_accessor :data,
    payment_provider: :string,
    payment_phone: :string

  def self.search(query)
    return all.not_deleted.order('created_at asc') if query.blank?
    build_where_query(all, query).order('created_at asc')
  end

  def self.build_where_query(all, query)
    queries = all.not_deleted
    queries = queries.where("created_at >=  ?", query[:created_from]) unless query[:created_from]
    queries = queries.where("created_at <=  ?", DateTime.strptime(query[:created_to], "%m/%d/%Y").end_of_day) unless query[:created_to]
    queries
  end


  def has_paid_payment?
    payments.exists?(status: 3)
  end

  def valid_payment
    payments.find_by(status: 3)
  end

  def has_pending_payment?
    payments.exists?(status: [0, 1])
  end

  def has_failed_payment?
    payments.exists?(status: [2, 4])
  end
end