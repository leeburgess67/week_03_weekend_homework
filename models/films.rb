require_relative("../db/sql_runner")
require_relative("./customers.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (
      title
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@title]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new( film ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

#   def locations()
#     sql = "SELECT locations.*
#     FROM locations
#     INNER JOIN visits
#     ON visits.location_id = locations.id
#     WHERE user_id = $1"
#     values = [@id]
#     locations = SqlRunner.run(sql, values)
#     return Location.map_items(locations)
#   end
#
#   def self.map_items(user_data)
#   return user_data.map { |location| Location.new(location) }
#   end
end
