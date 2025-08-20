class Payment < ApplicationRecord

  enum provider: { mobile: 0, alizza: 1}
  enum status: {initiated: 0, pending: 1, failed: 2, success: 3, expired: 4}

  jsonb_accessor :metadata,
    trid: :string,
    txnid: :string,
    data: :json,
    code: :json,
    vote_code: :json,
    vote_number: :json,
    ipay_reference: :string

end
