class PerItemQuantityDiscount
  def initialize(product_code:, discount:)
    @product_code = product_code
    @discount = discount
  end

  def apply(items: [], basket_total: nil)
    filtered_items = items.select{ |item| item.code == product_code }
    discount.call(filtered_items.size, filtered_items.first)
  end

  private

  attr_reader :product_code, :discount
end
