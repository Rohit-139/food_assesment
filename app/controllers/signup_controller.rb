class SignupController < ApplicationController
  def index
  end
  
  def new
    @user = User.new 
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
      WelcomeMailMailer.with(user: @user).welcome_user.deliver_now
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



end
