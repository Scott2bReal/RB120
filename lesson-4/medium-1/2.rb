# Alan created the following code to keep track of items for a shopping cart
# application he's writing:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# The mistake is that on line 11, a new local variable quantity is being
# initialized. To fix this, @quantity should be called since there is not setter
# method for quantity. If there were a setter method then self.quantity could be
# called.
