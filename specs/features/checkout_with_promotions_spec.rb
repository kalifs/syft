require 'minitest/autorun'
require 'checkout'
require 'product'
require 'rules/basket_total_discount'
require 'rules/per_item_quantity_discount'

describe 'Checkout with' do
  def products
    @products ||= {
      lavender_heart: Product.new(code: '001', name: 'Lavender heart', price: 9.25),
      cufflinks: Product.new(code: '002', name: 'Personalised cufflinks', price: 45.00),
      tshirt: Product.new(code: '003', name: 'Kids T-shirt', price: 19.95)
    }
  end

  def rules
    @rules ||= {
      basket_discount: BasketTotalDiscount.new(basket_minimum: 60.00, discount: 0.10),
      lavender_heart_discount: PerItemQuantityDiscount.new(
        product_code: '001',
        discount: Proc.new{|item_count, product| item_count >= 2 ? item_count * (product.price - 8.50) : 0 }
      )
    }
  end

  it '10% discount when total basket value is greater than £60' do
    checkout = Checkout.new([rules[:basket_discount]])
    checkout.scan(products[:lavender_heart])
    checkout.scan(products[:cufflinks])
    checkout.scan(products[:tshirt])

    assert_equal(66.78, checkout.total)
  end

  it 'prices of £8.50 per lavender heartr when 2 or more are purchased' do
    checkout = Checkout.new([rules[:lavender_heart_discount]])
    checkout.scan(products[:lavender_heart])
    checkout.scan(products[:tshirt])
    checkout.scan(products[:lavender_heart])

    assert_equal(36.95, checkout.total)
  end

  it 'gives 10% discount and reduce prices for each card holder when basket total is over £60 and there are 2 card holders' do
    checkout = Checkout.new([rules[:lavender_heart_discount], rules[:basket_discount]])
    checkout.scan(products[:lavender_heart])
    checkout.scan(products[:cufflinks])
    checkout.scan(products[:lavender_heart])
    checkout.scan(products[:tshirt])
    assert_equal(73.76, checkout.total)
  end
end
