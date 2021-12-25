# We created a simple BankAccount class with overdraft protection, that does not
# allow a withdrawal greater than the amount of the current balance. We wrote
# some example code to test our program. However, we are surprised by what we
# see when we test its behavior. Why are we seeing this unexpected output? Make
# changes to the code so that we see the appropriate behavior.

class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    # if amount > 0
    # New code should read
    if amount > 0 && amount <= balance
      success = (self.balance -= amount)
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def balance=(new_balance)
    # This code is unecessary
    # if valid_transaction?(new_balance)
    #   @balance = new_balance
    #   true
    # else
    #   false
    # end
    @balance = new_balance
  end

  # This method is unecessary
  # def valid_transaction?(new_balance)
  #   new_balance >= 0
  # end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal
                          #    to current balance ($50).
                          #    Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50

# Setter methods always return the argument passed in, regardless of any side
# effects that happen inside the method body. They are different than regular
# methods in ruby in this way. Even if something is explicitly returned they
# will always return the argument passed in. In this case, the code inside of
# the the balance setter method is unecessary, as all that is needed is
# reassignment of @balance. An && condition can be added to line 20 to account
# for an overdraft.

# Further exploration:
# A setter method will return the same object it is passed as an argument, even
# if that object is mutated.
