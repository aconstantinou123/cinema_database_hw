require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id']
  end

  def self.delete_all()
    sql = 'DELETE FROM tickets'
    SqlRunner.run(sql)
  end

  def self.list_all()
    sql = 'SELECT * FROM tickets'
    tickets = SqlRunner.run(sql)
    return tickets.map{|ticket| Ticket.new(ticket)}
  end

  def save()
    sql = 'INSERT INTO tickets (
            customer_id,
            film_id
            ) VALUES (
              $1,
              $2
              )
              RETURNING *'
    values = [@customer_id, @film_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end


end
