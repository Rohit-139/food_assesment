class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      token = JsonWebToken.encode(user_id: user.id, type: user.type)

      cookies.encrypted[:jwt] = {
        value: token,
        httponly: true
        }

      redirect_after_login(user)
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    cookies.delete(:jwt)
    redirect_to login_path
  end

  private
  def session_params
    params.require(:sessions).permit(:email, :password)
  end

 def redirect_after_login(user)
   if user.is_a?(Owner)
     redirect_to restaurants_path
   else
    redirect_to customers_dashboard_path
   end
 end
end
