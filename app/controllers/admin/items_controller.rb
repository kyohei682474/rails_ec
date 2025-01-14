# frozen_string_literal: true

module Admin
  class ItemsController < ApplicationController
    before_action :set_target_item, only: %i[edit update destroy]
    before_action :basic_auth_admin, only: %i[index new]
    
    def index
      @items = Item.all.oldest
    end

    def new
      @item = Item.new 
    end

    def create
      @item = Item.new(item_params)   
      if @item.save
        redirect_to admin_items_url, notice: "#{@item.name}を登録しました"
      else
        flash.now[:error_messages] = @item.errors.full_messages 
        render :new, status: :unprocessable_entity
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

    def basic_auth_admin
      authenticate_or_request_with_http_basic do |username, password|
     if username == ENV["BASIC_AUTH_USERNAME"] && password == ENV["BASIC_AUTH_PASSWORD"]
        true
     else
      render plain: "認証に失敗しました。正しい認証情報を入力してください。", status: :unauthorized
     end
     end
    end
  end
end