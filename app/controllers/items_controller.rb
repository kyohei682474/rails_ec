class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.latest
  
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :image)
  end

end
