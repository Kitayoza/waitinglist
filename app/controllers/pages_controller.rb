# app/controllers/pages_controller.rb
class Specialization
  attr_reader :id, :name, :description

  def initialize(attributes)
    @id = attributes['id']
    @name = attributes['name']
    @description = attributes['description']
  end
end

class Doctor
  attr_reader :id, :full_name, :specialization_id, :description, :price

  def initialize(attributes)
    @id = attributes['id']
    @full_name = attributes['full_name']
    @specialization_id = attributes['specialization_id']
    @description = attributes['description']
    @price = attributes['price']
  end

  def self.where(conditions)
    query = "SELECT * FROM doctors"
    query += " WHERE #{conditions.map { |k, v| "#{k} = #{v}" }.join(' AND ')}" if conditions.any?

    db = SQLite3::Database.new("blog.db")
    db.results_as_hash = true
    db.execute(query).map { |doc| Doctor.new(doc) }
  end
end

class PagesController < ApplicationController
  def main
    require 'sqlite3'

    db = SQLite3::Database.new("blog.db")
    db.results_as_hash = true

    @specializations = db.execute("SELECT * FROM specializations").map do |spec|
      Specialization.new(spec)
    end

    db.close
  end
end