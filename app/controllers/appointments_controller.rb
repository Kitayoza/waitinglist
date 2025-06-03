class AppointmentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    unless params[:user_login].present?
      render json: { 
        status: 'error', 
        message: 'Требуется авторизация для записи' 
      }, status: :unauthorized
      return
    end
  
    begin
      db = SQLite3::Database.new("blog.db")
      db.execute(
        "INSERT INTO appointments (...) VALUES (?, ?, ?, ?, ?)",
        [params[:user_login], params[:doctor_id], params[:doctor_name], 
         params[:date], params[:time]]
      )
      render json: { status: 'success' }
    rescue => e
      render json: { status: 'error', message: e.message }, status: 500
    ensure
      db.close if db
    end
  end
end