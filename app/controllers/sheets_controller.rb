class SheetsController < ApplicationController

  def index
    @sheets = Sheet.all
  end

  def show
    @sheet = Sheet.find(params[:id])
  end

  def new
    @sheet = Sheet.new
  end    

  def edit
    @sheet = Sheet.find(params[:id])
  end

  def create
    @sheet = Sheet.new(sheet_params)

    if @sheet.save
      redirect_to @sheet
    else
      render 'new'
    end
  end

  def update
    @sheet = Sheet.find(params[:id])

    if @sheet.update(sheet_params)
      redirect_to @sheet
    else
      render 'edit'
    end
  end

  private
  def sheet_params
    params.require(:sheet).permit(:name)
  end

end
