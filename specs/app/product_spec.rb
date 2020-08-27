require 'minitest/autorun'
require 'product'

describe Product do
  def product
    @product ||= Product.new(code: 'the_code', name: 'the name', price: 9.99)
  end

  it 'has code' do
    assert_equal('the_code', product.code)
  end

  it 'has name' do
    assert_equal('the name', product.name)
  end

  it 'has price' do
    assert_equal(9.99, product.price)
  end
end
