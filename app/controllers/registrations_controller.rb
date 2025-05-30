class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Регистрация прошла успешно!'
    else
      flash.now[:alert] = "Не удалось зарегистрироваться"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :password)
  end
end