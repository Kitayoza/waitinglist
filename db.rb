require 'sqlite3'

# Подключаемся к базе данных SQLite3
db = SQLite3::Database.new("blog.db")

# Таблица пользователей (логины и пароли)
create_users_table_sql = <<-SQL
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    login TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
);
SQL

# Таблица записей на прием
create_appointments_table_sql = <<-SQL
CREATE TABLE IF NOT EXISTS appointments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    doctor_name TEXT NOT NULL,
    user_login TEXT NOT NULL REFERENCES users(login),
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL
);
SQL

# Таблица врачей с описанием
create_doctors_table_sql = <<-SQL
CREATE TABLE IF NOT EXISTS doctors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT
);
SQL

# Выполняем SQL-запросы для создания таблиц
db.execute(create_users_table_sql)
db.execute(create_appointments_table_sql)
db.execute(create_doctors_table_sql)

puts "Таблицы успешно созданы!"
