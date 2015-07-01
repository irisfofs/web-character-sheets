class StatisticsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @sheet = Sheet.find(params[:sheet_id])
    @statistic = @sheet.statistics.create(statistic_params)

    # Render show
  end

  def show
    # return stuff
    # write jsonbuilder partial and template 

  end

  def update
    @sheet = Sheet.find(params[:sheet_id])
    @statistic = @sheet.statistics.find(params[:id])

    @statistic.update(statistic_params)
    head :no_content
    # TODO: Return value of success or failure
  end

  private
  def statistic_params 
    params.require(:statistic).permit(:name,:base_value,:expression)
  end
end
