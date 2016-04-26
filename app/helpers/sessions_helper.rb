module SessionsHelper

	# Logs in given user and creates temporary cookie in browser
	def log_in(user)
		session[:user_id] = user.id
	end

	# Remembers the user in cookies
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	# Forgets a user in cookies
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# Logs out the user and sets current_user as nil
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	# Returns the current user and retrieves it if it hasnt already
	def current_user
		if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
	end

	# Checks log-in status of use
	def logged_in?
		!current_user.nil?
	end
end
