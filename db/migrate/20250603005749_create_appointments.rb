class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.string :user_login, null: false
      t.references :doctor, null: false, foreign_key: true
      t.string :doctor_name, null: false
      t.date :appointment_date, null: false
      t.time :appointment_time, null: false
      t.timestamps
    end
  end
end
