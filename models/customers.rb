require_relative("../db/sql_runner")
require_relative("./films.rb")
require_relative("./tickets.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end

  def self.all() #class method
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values) #returns an array of hashes
    result = customers.map { |customer| Customer.new( customer ) } #for each item(hash) in array, iterate over and pass that hash to Customer.new to create a new customer object.
    return result #returns each customer object
  end

  def update
    sql = "UPDATE customers SET name = $1, funds = $2 WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return Film.map_items(films)
  end

  def self.map_items(user_data)
  return user_data.map { |customer| Customer.new(customer) }
  end

  def buy_ticket(film) #passing in a film object
    @funds -= film.price #acceesses the price from the film object
    Ticket.new({ 'customer_id' => @id,  'film_id' => film.id }).save
    update() #ticket.new must take in a hash so you pass it in the customer id (as you are calling the method on a specific customer) and you are givng it the film_id of the film passed in.

  end

  def check_tickets()
    sql = 'SELECT tickets.*
    FROM tickets
    WHERE customer_id = $1'
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return Ticket.map_items(tickets)
  end
end
