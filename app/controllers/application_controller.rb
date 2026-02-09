class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :authenticate_user
  attr_accessor :current_user
  helper_method :current_user

  def authenticate_user
    token = cookies.encrypted[:jwt]
    return unless token
    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded
  end

   def require_owner
    unless current_user.is_a?(Owner)
      redirect_to root_path, alert: "Access denied"
    end
  end

  def current_user
        @current_user
  end

  def require_customer
    unless current_user.is_a?(Customer)
      redirect_to root_path, alert: "Access denied"
    end
  end
end
