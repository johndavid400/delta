class Account < ActiveRecord::Base
  attr_accessible :allocation_rate, :balance, :name, :principal, :user_id

  belongs_to :user

end
