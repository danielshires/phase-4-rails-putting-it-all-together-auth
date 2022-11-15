class SessionsController < ApplicationController

    def create

        user = User.find_by(username: params[:username])

        if user &.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: {errors: [ "Incorrect username or password" ]}, status: :unauthorized
        end
    end

    def destroy
        user_id = session[:user_id]
        if user_id
            session.delete :user_id
            head :no_content
        else
            render json: {errors: [ "Not logged in" ] }, status: :unauthorized
        end
    end

end