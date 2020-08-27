class Checkout
  attr_reader :basket_total

  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @items = []
    @basket_total = 0
  end

  def scan(item)
    @items << item
    @basket_total += item.price
    nil
  end

  def total
    total_with_discounts
  end

  def total_with_discounts
    round_to_pence(
      promotional_rules.reduce(basket_total) { |new_total, rule|
        new_total - rule.apply(items: items, basket_total: new_total)
      }
    )
  end

  def round_to_pence(amount)
    amount.round(2)
  end

  attr_reader :items, :promotional_rules
end
