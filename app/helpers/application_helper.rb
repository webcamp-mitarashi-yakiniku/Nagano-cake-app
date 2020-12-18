module ApplicationHelper

  def tax(price)
    money = price * 1.1
    total_price = money.round
    total_price.to_s(:delimited, delimiter: ',')
  end

  def converting_to_jpy(price)
    price.to_s(:delimited, delimiter: ',')
  end

end
