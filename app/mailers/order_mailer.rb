# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_detail_email
    # withメソッドでwith(order: @order)と指定しているのでparams[:order]として@orderにアクセスできる
    @order = params[:order]
    mail(
      subject: I18n.t('order_mailer.thank_you_subject'),
      to: @order.email,
      from: 'rails_ec@example.com'
    )
  end
end
