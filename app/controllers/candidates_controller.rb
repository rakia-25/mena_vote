class CandidatesController < ApplicationController
  layout 'candidates'
  # skip_before_action :verify_authenticity_token, only: [:voter, :show]
  # skip_before_action :authenticate_user!, only: [:voter, :show]

  def show
    @setting = Setting.first
    redirect_to root_path and return unless @setting.show_candidate_section?
    redirect_to root_path and return unless @setting.vote?

    @candidate = Candidate.includes(:categories).find_by(vote_code: params[:id])
    raise ActionController::RoutingError.new('Not Found') unless @candidate

    @current_year = Year.find_by(current_year: true)
    @candidate.decorate

    candidate_category_ids = @candidate.categories.pluck(:id)

    @candidates = Candidate.in_categories(candidate_category_ids)
                       .where(year_id: @current_year.id)
                       .includes(:categories)
                       .order(:name, 'categories.name')

    @candidates_votes_cat_start = @candidates.where("votes > 0").count
  end

  def candidate_name
    @candidate = Candidate.includes(:categories).find_by(vote_code: params[:vote_code])
    render json: { name: @candidate.name, categories: @candidate.categories }
  end

  private
  def candidate_params
    params.require(:candidate).permit(

    )
  end

  def filter_params
    
  end
end
