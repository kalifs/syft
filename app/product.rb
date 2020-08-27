class Product
  attr_reader :code, :name, :price

  def initialize(code:, name:, price:)
    @code = code
    @name = name
    @price = price
  end

  def to_s
    "  code:  #{code}\n  name:  #{name}\n  price: #{price}\n"
  end
end
