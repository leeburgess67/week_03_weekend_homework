require_relative("../db/sql_runner")
require_relative("./customers.rb")
require_relative("./tickets.rb")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i

  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id,

    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customer_id, @film_id,]
    visit = SqlRunner.run( sql,values ).first
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = Ticket.map_items(tickets)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end
  # 
  # def location()
  #   sql  = "SELECT * FROM locations WHERE id = $1"
  #   values = [@location_id]
  #   location = SqlRunner.run(sql, values).first #store a hash as location
  #   return Location.new(location)
  # end
  #
  # def user()
  #   sql = "SELECT * FROM users WHERE id = $1"
  #   values = [@user_id]
  #   user = SqlRunner.run(sql, values).first
  #   return User.new(user)
  # end
  #
  #
  # def self.map_items(visit_data)
  #   return visit_data.map { |visit| Visit.new(visit) }
  # end
  #
  #





end
