class SheetsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @sheets = if params[:keywords]
                Sheet.where("name ilike ?", "%#{params[:keywords]}%")
              else
                []
              end
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

  # TODO: Define in terms of create, or vice versa
  def create!(name:)
    @sheet = Sheet.new(name)

    @sheet.save
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
