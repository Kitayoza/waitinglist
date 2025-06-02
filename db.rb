# db.rb
require 'sqlite3'

db = SQLite3::Database.new("blog.db")

# Удаляем существующие таблицы (если нужно пересоздать структуру)
db.execute("DROP TABLE IF EXISTS appointments")
db.execute("DROP TABLE IF EXISTS doctors")
db.execute("DROP TABLE IF EXISTS specializations")
db.execute("DROP TABLE IF EXISTS users")

# Создаем таблицу специализаций
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS specializations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    description TEXT
  );
SQL

# Создаем таблицу врачей
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS doctors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    specialization_id INTEGER NOT NULL,
    description TEXT,
    price INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (specialization_id) REFERENCES specializations(id)
  );
SQL

# Заполняем таблицы тестовыми данными
if db.get_first_value("SELECT COUNT(*) FROM specializations") == 0
  db.execute <<-SQL
    INSERT INTO specializations (name, description) VALUES
      ('Аллерголог-иммунолог', 'Аллергии и иммунные нарушения'),
      ('Гастроэнтеролог', 'Заболевания ЖКТ'),
      ('Гематолог', 'Заболевания крови');
  SQL
end

if db.get_first_value("SELECT COUNT(*) FROM doctors") == 0
  db.execute <<-SQL
    INSERT INTO doctors (full_name, specialization_id, description, price) VALUES
      ('Борщ Иван Сергеевич', 1, NULL, 2000),
      ('Веленчук Екатерина Александровна', 2, NULL, 2100),
      ('Дукова Ольга Артуровна', 2, NULL, 2300),
      ('Иванов Сергей Валерьевич', 3, NULL, 1950);
  SQL
end

db.close
puts "База данных успешно инициализирована!"