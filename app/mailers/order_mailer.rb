class OrderMailer < ApplicationMailer
  def order_detail_email
    #withメソッドでwith(order: @order)と指定しているのでparams[:order]として@orderにアクセスできる
    @order = params[:order]
    mail(
      subject: "ご購入ありがとうございます" ,
      to: @order.email, 
      from: 'rails_ec@example.com'
      )
  end
end
