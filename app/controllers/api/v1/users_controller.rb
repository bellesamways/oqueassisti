module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :edit, :update, :destroy]

      # GET /users
      def index
        @users = User.all
      end
    
      # GET /users/:id
      def show
      end

      # POST /users
      def create
        debugger
        @user = User.new(user_params)
        if @user.save
          render :show, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/1
      def update
        if @user.update(user_params)
          render :show, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/1
      def destroy
        @user.destroy

        head :ok
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def user_params
          params.require(:user).permit(:name, :email, :username, :password)
        end
    end
  end
end

