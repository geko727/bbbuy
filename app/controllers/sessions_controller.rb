class SessionsController < ApplicationController
	def new
	end

	def create 

		user = User.where(email: params[:email]).first
		
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to series_index_path, notice: "You are signed in"
		else
			
			redirect_to "/"
		end
	end

	def destroy 
		session[:user_id] = nil
		redirect_to "/"
	end

end		