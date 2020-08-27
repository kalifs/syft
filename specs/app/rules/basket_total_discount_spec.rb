require 'minitest/autorun'
require 'ostruct'
require 'rules/basket_total_discount'

describe BasketTotalDiscount do
  describe '#apply' do
    def rule
      BasketTotalDiscount.new(basket_minimum: 100.00, discount: 0.05)
    end

    it 'give 5% discount when basket total is >= 100' do
      assert_equal(5.0, rule.apply(items: [], basket_total: 100.0))
    end

    it 'does not give discount when basket total is below basket minimums' do
      assert_equal(0, rule.apply(items: [], basket_total: 99.99))
    end
  end
end
