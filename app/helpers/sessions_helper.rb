module SessionsHelper

	def sign_in(user)
		#create a unique cookie for the user base on the salt (used to hash the password)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		#||= is "or equals"
		#here current_user is set to the user corresponding to the remember token
		@current_user ||= user_remember_token
	end

	def signed_in?
		#just make sure the current user is not nil (they're signed in)
		!current_user.nil?
	end

	def sign_out
		#sign the user out by deleting the cookie and resetting the current user to nil
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	private

		def user_remember_token
			User.authenticate_with_salt(*remember_token)
		end

		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
		end
end
