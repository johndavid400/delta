class AccountsController < ApplicationController
  before_filter :get_user

  def get_user
    current_user.email
    @user = current_user
  rescue
    redirect_to root_path
  end

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = @user.accounts.sort

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.json
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = @user.accounts.new(params[:account])

    @account.balance = 0
    @account.principal = 0
    @account.allocation_rate = params[:allocation_rate]

    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_path, notice: 'Account was successfully created.' }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @account = Account.find(params[:id])
    respond_to do |format|
      if @account.update_attributes(params[:account])
        @account.allocation_rate = params[:allocation_rate]
        @account.save
        format.html { redirect_to accounts_path, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end

  def transfer_from
    @account = Account.find(params[:account_id])
    @to_accounts = current_user.accounts.select{|s| s!= @account }
  end

  def transfer
    to_account = Account.find(params[:to_account])
    from_account = Account.find(params[:from_account])

    from_account.balance = from_account.balance - BigDecimal.new(params[:amount])
    from_account.principal = from_account.principal - BigDecimal.new(params[:amount])

    to_account.balance = to_account.balance + BigDecimal.new(params[:amount])
    to_account.principal = to_account.principal + BigDecimal.new(params[:amount])

    from_account.save
    to_account.save

    redirect_to accounts_path
  end

  def get_funds
    @banks = [{"amount" => 12000, "name" => "Wells Fargo: xxxx8949"}, {"amount" => 19200, "name" => "E-trade: xxxx3434"}, {"amount" => 49000, "name" => "Regions: xxxx2343"}]
  end

  def infuse
    @account = Account.find(params[:account])
    @account.balance = @account.balance + params[:amount].to_d
    @account.principal = @account.principal + params[:amount].to_d
    @account.save
    redirect_to accounts_path
  end

end



