# frozen_string_literal: true

module Admin
  class ItemsController < ApplicationController
    before_action :set_target_item, only: %i[edit update destroy]

    def index
      @items = Item.all.order(created_at: :asc)
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
    end

    def update     
      @item.update!(item_params)
      redirect_to admin_items_url, notice: "#{@item.name}を更新しました"
    end

    def destroy 
      @item.destroy
      redirect_to admin_items_url, notice: "#{@item.name}を削除しました"
    end

    private

    def item_params
      params.require(:item).permit(:name, :price, :description, :image)
    end

    def set_target_item
      @item = Item.find(params[:id])
    end

  end
end