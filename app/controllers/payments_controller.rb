class PaymentsController < ApplicationController
    def pay
        unless current_user
            render json: {message: "Sign up or log in"}, status: :unauthorized
            return
        end

        amount=params.fetch(:amount)
        unless amount
            render json: {message: "Enter amount"}, status: :unprocessable_entity
            return
        end

        amount=amount.to_i
        user_status=Status.find_or_create_by(username: current_user.username)
        current_class=user_status.views
        if amount>current_class
            user_status.views=amount
        end
        user_status.subscription_date=Date.today
        user_status.save
        render json: {message: "your allowed view counts have been upgraded"}, status: :ok
    end
end
