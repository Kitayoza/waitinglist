class Specialization
  attr_reader :id, :name, :description

  def initialize(attributes)
    @id = attributes['id']
    @name = attributes['name']
    @description = attributes['description']
  end
end

