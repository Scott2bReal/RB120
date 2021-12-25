# Consider the following class:

class Machine

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  # Further exploration
  def show_state
    switch
  end

  private

  # Further exploration
  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

# Modify this class so both flip_switch and the setter method switch= are
# private methods.
