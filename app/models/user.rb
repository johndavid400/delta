class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :accounts

  def bank_account
    account = accounts.select{|s| s.name == "Bank" }.first
    account.name
    return account
  rescue
    account = accounts.create name: "Bank", balance: BigDecimal.new(500), principal: BigDecimal.new(500)
    return account
  end

  def total_account_balance
    self.accounts.map{|s| s.balance }.sum
  end

  def total_principal_balance
    self.accounts.map{|s| s.principal }.sum
  end

  def total_return_rate
    (total_account_balance / total_principal_balance) - 1
  end

  def total_earned
    total_account_balance - total_principal_balance
  end

end
