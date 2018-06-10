require_relative("../db/sql_runner")
require_relative("./tickets.rb")
require_relative("./films.rb")

class Screening

  attr_reader :id
  attr_accessor :film_id, :time_showing

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @time_showing = options['time_showing']

  end

  def save()
    sql = "INSERT INTO screenings
    (
      film_id,
      time_showing
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@film_id, @time_showing]
    screening = SqlRunner.run( sql,values ).first
    @id = screening['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    result = Screening.map_items(screenings)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM screening"
    SqlRunner.run(sql)
  end

  def self.map_items(screening_data)
    return screening_data.map { |screening| Screening.new(screening) }
  end








end
