require_relative("../db/sql_runner")
require_relative("./films.rb")

class Customer

  attr_reader :id
  attr_accessor :name :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM users"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM users"
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
# end
