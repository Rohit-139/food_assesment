class SignupController < ApplicationController
  def index
  end
  
  def new
    @user = User.new 
  end

  def new_owner
    @owner = Owner.new
    render "home_owner"
  end

  def new_customer
    @customer = Customer.new
    render "home_customer"
  end

  def create 
    @user = User.new(user_params) 
    type = params[:user][:type]
    if 
      type == "1" 
      @user.type = "Owner"
    else 
      @user.type = "Customer"
    end
    if @user.save
      redirect_to login_path, notice: "signup successfully"
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  def create_customer
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to login_path, notice: "Customer account created successfully"
    else
      flash.now[:alert] = @customer.errors.full_messages.to_sentence
      render :home_customer, status: :unprocessable_entity
    end
  end

  def create_owner
    @owner = Owner.new(owner_params)
    if @owner.save
      redirect_to login_path, notice: "Owner account created successfully"
    else
      flash.now[:alert] = @owner.errors.full_messages.to_sentence
      render :home_owner, status: :unprocessable_entity
    end
  end

  def customer_params
    params.require(:customer)
          .permit(:name, :email, :password, :password_confirmation)
  end

  def owner_params
    params.require(:owner)
          .permit(:name, :email, :password, :password_confirmation)
  end
end
