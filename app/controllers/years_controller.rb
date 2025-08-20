class YearsController < GenericsController

  private

  def year_params
    params.require(:year).permit(
      :name
    )
  end
end
