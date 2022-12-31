class Admins::ProductionsController < ApplicationController
  def index
    @production = Production.new
    @productions = Production.all
  end

  def create
    @production = Production.new(production_params)
    if @production.save
      redirect_to admins_productions_path
    else
      @productions = Production.all
      render :index
    end
  end

  def destroy
    @production = Production.find(params[:id])
    @production.destroy
    redirect_to  admins_productions_path
  end

  private

  def production_params
    params.require(:production).permit(:title, :introduction, :image)
  end
end
