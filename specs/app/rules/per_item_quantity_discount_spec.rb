require 'minitest/autorun'
require 'ostruct'
require 'rules/per_item_quantity_discount'

describe PerItemQuantityDiscount do
  describe '#apply' do
    def rule
      PerItemQuantityDiscount.new(
        product_code: 'abc',
        discount: Proc.new{ |item_count, product| item_count >= 3 ? item_count * (product.price - 10.00) : 0})
    end

    it 'drops items price to £10.00 when 3 or more items are bought' do
      items = [
        OpenStruct.new(code: 'abc', price: 12.00),
        OpenStruct.new(code: 'abc', price: 12.00),
        OpenStruct.new(code: 'abc', price: 12.00),
        OpenStruct.new(code: 'abc', price: 12.00),
      ]
      assert_equal(8.00, rule.apply(items: items))
    end

    it 'does not apply rule when there is less then 3 product of given code' do
      items = [
        OpenStruct.new(code: 'abc', price: 12.00),
        OpenStruct.new(code: 'abc', price: 15.00),
        OpenStruct.new(code: 'abf', price: 15.00)
      ]
      assert_equal(0, rule.apply(items: items))
    end
  end
end
