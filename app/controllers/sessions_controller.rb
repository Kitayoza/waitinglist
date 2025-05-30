class SessionsController < ApplicationController
  def new
    # Просто отображает форму входа
  end

  def create
    user = User.find_by(login: params[:login])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Вы успешно вошли в систему!'
    else
      flash.now[:alert] = 'Неверный логин или пароль'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Вы успешно вышли из системы'
  end
end