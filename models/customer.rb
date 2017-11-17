require_relative("../db/sql_runner")
require_relative("./film")
require_relative("./ticket")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i

  end

    def self.delete_all()
      sql = 'DELETE FROM customers'
      SqlRunner.run(sql)
    end

    def self.list_all()
      sql = 'SELECT * FROM customers'
      customers = SqlRunner.run(sql)
      return customers.map{|customer| Customer.new(customer)}
    end

    def save()
      sql = 'INSERT INTO customers (
        name,
        funds
      ) VALUES (
        $1,
        $2
        )
        RETURNING *'
      values = [@name, @funds]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
      sql = 'UPDATE customers SET (
       name,
       funds
       ) = (
          $1,
          $2
            )
        WHERE id = $3
        '
        values = [@name,@funds, @id]
        SqlRunner.run(sql, values)
    end

    def film()
      sql = 'SELECT films.*
             FROM films
             INNER JOIN tickets
             ON tickets.film_id = films.id
             WHERE tickets.customer_id = $1'
      values = [@id]
      films = SqlRunner.run(sql, values)
      return films.map{|film| Film.new(film)}
    end

    def buy_ticket(screening)
      sql = 'INSERT INTO tickets (
      customer_id,
      film_id
      ) VALUES (
        $1,
        $2
        )'
      values = [@id, screening.film_id.to_i]
      SqlRunner.run(sql, values)
    end



end
