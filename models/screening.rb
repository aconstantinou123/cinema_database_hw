require_relative('../db/sql_runner')

class Screening

  attr_reader :id
  attr_accessor :film_id, :start_time, :empty_seats

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @start_time = options['start_time']
    @empty_seats = options['empty_seats'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM screenings'
    SqlRunner.run(sql)
  end

  def self.list_all
    sql = 'SELECT * FROM screenings'
    screenings = SqlRunner.run(sql)
    return screenings.map{|screening| Screening.new(screening)}
  end

  def save()
    sql = 'INSERT INTO screenings (
      film_id,
      start_time,
      empty_seats
      ) VALUES (
      $1,
      $2,
      $3
      )
      RETURNING *'
    values = [@film_id, @start_time, @empty_seats]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.most_popular
    sql = 'SELECT screenings.*
          FROM screenings
          INNER JOIN tickets
          ON tickets.film_id = screenings.film_id
          GROUP BY tickets.film_id, screenings.id
          ORDER BY COUNT (customer_id) DESC
          LIMIT 1 OFFSET 0'
    most_popular = SqlRunner.run(sql)
    return most_popular.map{|screening| Screening.new(screening)}
  end



end
