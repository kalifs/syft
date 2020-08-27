class BasketTotalDiscount
  def initialize(basket_minimum:, discount:)
    @basket_minimum = basket_minimum
    @discount = discount
  end

  def apply(items: nil, basket_total: 0)
    if basket_total >= basket_minimum
      basket_total * discount
    else
      0
    end
  end

  private

  attr_reader :basket_minimum, :discount
end
