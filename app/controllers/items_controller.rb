class ItemsController < ApplicationController
  def index
    @items = Item.with_attached_image
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.where.not(id: @item.id).latest.limit(3)
  
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :image)
  end

end
