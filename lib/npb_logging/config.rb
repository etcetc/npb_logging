module NpbLogging
  class Config
    class << self
      # define the name of the user_id keys in the session
      # The reason there are several is that sometimes you may have one called user_id, for example
      # but if there is no user_id, you may want to print something else, like a temporary user id
      def user_id_session_keys=(keys)
        @user_id_names = Array(keys)
      end

      def user_id_session_keys
        @user_id_names || [:user_id,:tmp_user_id]
      end

    end
  end
end