# frozen_string_literal: true

module Admin
  class ItemsController < ApplicationController
    def index
      @items = Item.all
    end

    def new
      @item = Item.new      
    end

    def create
      @item = Item.new(item_params)   
      
      if @item.save
        redirect_to admin_items_url, notice: "#{@item.name}を登録しました"
      else
        render :new
      end
    end

    def edit
      @item = Item.find(params[:id])
    end

    def update
      item = Item.find(params[:id])
      item.update!(item_params)
      redirect_to admin_items_url, notice: '#{item.name}を更新しました'
    end

    def destory
      
    end

    private

    def item_params
      params.require(:item).permit(:name, :price, :description, :image)
    end
  end
end