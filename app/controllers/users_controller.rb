class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end
	
	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to @user, notice: "Thanks for signing up!"
		else
			render :new
		end 
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		if @user.save
			redirect_to @user, notice: "Details updated" 
		else
			render :edit
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to root_path, alert: "Account successfully deleted!"
	end

private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :username)
	end 


end
