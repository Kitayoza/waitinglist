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