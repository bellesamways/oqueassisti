module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]

      # GET /users
      def index
        @users = User.all
        render json: @users, status: :ok
      end

      # GET /users/:id
      def show
        render json: @user
      end

      # POST /users
      def create
        @user = User.new(user_params)

        if @user.save
          redirect_to action: :show, id: @user.id, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/1
      def update
        if @user.update(user_params_update)
          redirect_to action: :show, id: @user.id, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH /users/1
      def update_password
        @user = User.find(params[:id])

        @user.old_password = user_params_update_password['old_password']
        @user.password = user_params_update_password['password']

        if @user.valid? && !@user.password.nil?
          @user.save!
          redirect_to action: :show, id: @user.id, status: :ok
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

      def user_params_update
        params.require(:user).permit(:name, :email, :username, :old_password)
      end

      def user_params_update_password
        params.require(:user).permit(:password, :old_password)
      end
    end
  end
end
