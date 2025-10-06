class ClientsController < ApplicationController
  layout 'public'

  def index
    @payment = Payment.new
    @current_year = Year.find_by(current_year: true)
    @setting = Setting.first

    @candidates = Candidate.includes(:categories)
                           .where(year_id: @current_year.id)
                           .order(votes: :desc, updated_at: :desc)

    @first_candidates_votes = @candidates.where("votes > 0").count
    if @first_candidates_votes >= 1
      @first_candidate_by_votes_id = @candidates.first.id
    end

    @categories = Category.all.sort_by do |category|
      -@candidates.select { |c| c.categories.include?(category) }.size
    end
  end
end
