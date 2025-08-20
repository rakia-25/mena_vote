class ClientsController < ApplicationController
  layout 'public'

  def index
    @payment = Payment.new
    @current_year = Year.find_by(current_year: true)
    @setting = Setting.first

    @first_candidates_votes = Candidate.includes(:categories)
                                        .where("votes > ?", 0)
                                        .where(year_id: @current_year.id)
                                        .count
    if @first_candidates_votes >= 1
      @candidates = Candidate.includes(:categories)
                              .where(year_id: @current_year.id)
                              .order(votes: :desc, updated_at: :desc)

      @candidates_ids = @candidates.limit(3).pluck(:id)

      if @candidates.present?
        @first_candidate_by_votes_id = Candidate.find(@candidates_ids[0]).id
        @second_candidate_by_votes_id = Candidate.find(@candidates_ids[1]).id
        @third_candidate_by_votes_id = Candidate.find(@candidates_ids[2]).id
      end
    else
      @candidates = Candidate.includes(:categories)
                              .where(year_id: @current_year.id)
                              .order((Arel.sql("CAST(code AS INTEGER)")))
    end
  end
end
