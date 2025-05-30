class User < ApplicationRecord
  validates :login, 
    presence: { message: "не может быть пустым" },
    uniqueness: { message: "уже занят, выберите другой" }
  validates :password, 
    presence: { message: "не может быть пустым" },
    length: { minimum: 6, message: "должен содержать минимум 6 символов" }
end