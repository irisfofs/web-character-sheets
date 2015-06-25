class AttributesController < ApplicationController
  def create
    @sheet = Sheet.find(params[:sheet_id])
    @attribute = @sheet.attributes.create(attribute_params)
    redirect_to sheet_path(@sheet)
  end

  private
  def attribute_params 
    params.require(:attribute).permit(:name)
  end
end
