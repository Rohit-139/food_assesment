module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags "ActionCable", current_user.email
    end

    private

    def find_verified_user
      token = cookies.encrypted[:jwt]
      return reject_unauthorized_connection unless token

      decoded = JsonWebToken.decode(token)
      user = User.find_by(id: decoded["user_id"])

      user || reject_unauthorized_connection
    rescue
      reject_unauthorized_connection
    end
  end
end
