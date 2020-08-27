require 'minitest/autorun'
require 'ostruct'
require 'checkout'

describe Checkout do
  def new_checkout(promotional_rules = [])
    Checkout.new(promotional_rules)
  end

  it 'calculates total of all scanned items' do
    checkout = new_checkout
    checkout.scan(OpenStruct.new(price: 50))
    checkout.scan(OpenStruct.new(price: 4))
    assert_equal(54, checkout.total)
  end

  describe 'with promotional rules' do
    it 'apply rule' do
      rule = Minitest::Mock.new
      item_one = OpenStruct.new(price: 10)
      item_two = OpenStruct.new(price: 13)

      rule.expect :apply, 0, [{items: [item_one, item_two], basket_total: 23}]

      checkout = new_checkout([rule])
      checkout.scan(item_one)
      checkout.scan(item_two)
      checkout.total

      rule.verify
    end
  end
end
