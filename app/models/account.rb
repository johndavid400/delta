class Account < ActiveRecord::Base
  attr_accessible :allocation_rate, :balance, :name, :principal, :user_id

  belongs_to :user

  def return_rate
    if balance == 0
      "0.0"
    else
      (balance / principal) - 1
    end
  end

  def earned
    balance - principal
  end

end
