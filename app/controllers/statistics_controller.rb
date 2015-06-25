class StatisticsController < ApplicationController
  def create
    @sheet = Sheet.find(params[:sheet_id])
    @statistic = @sheet.statistics.create(statistic_params)
    redirect_to sheet_path(@sheet)
  end

  private
  def statistic_params 
    params.require(:statistic).permit(:name)
  end
end
