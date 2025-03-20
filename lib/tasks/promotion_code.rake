# frozen_string_literal: true

namespace :promotion_code do
  desc 'Generate 10 promotion codes'
  task generate: :environment do
    codes = []

    10.times do
      code = SecureRandom.alphanumeric(7)
      discount = rand(100..1000)

      promotion = PromotionCode.create!(
        code: code,
        discount_amount: discount,
        used: false
      )

      codes << "コード番号: #{promotion.code} 割引額: #{promotion.discount_amount}円"
    end

    puts 'プロモーションコード一覧'
    codes.each { |code| puts code }

    File.open('tmp/promotion_code.txt', 'w') do |file|
      codes.each { |code| file.puts(code) }
    end

    puts "\n→ tmp/promotion_code.txt にプロモーションコードが書き出されました"
  end
end
