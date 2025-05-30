require 'sqlite3'

db = SQLite3::Database.new("blog.db")

# Создание таблиц
create_users_table_sql = <<-SQL
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    login TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
);
SQL

create_appointments_table_sql = <<-SQL
CREATE TABLE IF NOT EXISTS appointments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    doctor_name TEXT NOT NULL,
    user_login TEXT NOT NULL REFERENCES users(login),
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL
);
SQL

create_doctors_table_sql = <<-SQL
CREATE TABLE IF NOT EXISTS doctors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT
);
SQL

db.execute(create_users_table_sql)
db.execute(create_appointments_table_sql)
db.execute(create_doctors_table_sql)

puts "Таблицы успешно созданы!"

# Дополнительно: Заполнение таблицы doctors (если она пуста)
if db.get_first_value("SELECT COUNT(*) FROM doctors") == 0
  db.execute <<-SQL
    INSERT INTO doctors (name, description) VALUES
      ('Иванов Сергей Петрович', 'Хирург высшей категории с 15-летним стажем.'),
      ('Петрова Анна Владимировна', 'Терапевт, кандидат медицинских наук.'),
      ('Смирнов Дмитрий Игоревич', 'Невролог с 10-летним опытом.'),
      ('Козлова Елена Александровна', 'Детский врач-стоматолог.'),
      ('Федоров Михаил Олегович', 'Кардиолог, доктор медицинских наук.');
  SQL
  puts "Таблица doctors заполнена тестовыми данными!"
else
  puts "Таблица doctors уже содержит данные, пропускаем заполнение."
end

db.close