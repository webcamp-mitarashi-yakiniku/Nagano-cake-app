module Customer::OrdersHelper
  # フルネームを取得
  def get_fullname(customer)
    customer.family_name + customer.first_name
  end

  # 支払い方法（日本語）を取得
  def how_to_pay(order)
    if order.payment_method == 0 then
      return "銀行振込"
    else
      return "クレジットカード"
    end
  end
end
