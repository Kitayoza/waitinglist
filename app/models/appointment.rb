class Appointment
  attr_reader :id, :user_login, :doctor_id, :doctor_name, :appointment_date, :appointment_time, :created_at

  def initialize(attributes)
    @id = attributes['id']
    @user_login = attributes['user_login']
    @doctor_id = attributes['doctor_id']
    @doctor_name = attributes['doctor_name']
    @appointment_date = attributes['appointment_date']
    @appointment_time = attributes['appointment_time']
    @created_at = attributes['created_at']
  end

  def self.create(params)
    db = SQLite3::Database.new("blog.db")
    db.execute(
      "INSERT INTO appointments (user_login, doctor_id, doctor_name, appointment_date, appointment_time) VALUES (?, ?, ?, ?, ?)",
      [params[:user_login], params[:doctor_id], params[:doctor_name], params[:date], params[:time]]
    )
    db.close
  end
end