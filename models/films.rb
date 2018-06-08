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

    def return_customers()
      sql = "SELECT customers.*
      FROM customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE film_id = $1"
      values = [@id]
      customers = SqlRunner.run(sql, values)
      return Customer.map_items(customers)
    end

    def update # EXTENSION
      sql = "UPDATE films SET title = $1, price = $2 WHERE id = $3"
      values = [@title, @price, @id]
      SqlRunner.run(sql, values)
    end
  #
    def self.map_items(user_data)
    return user_data.map { |film| Film.new(film) }
    end




end
