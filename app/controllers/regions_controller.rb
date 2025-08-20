class RegionsController < GenericsController

  private

  def region_params
    params.require(:region).permit(
      :name
    )
  end
end
