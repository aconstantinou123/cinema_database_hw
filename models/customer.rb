require_relative("../db/sql_runner")
require_relative("./film")
require_relative("./ticket")

class Customer

  attr_reader :id
  attr_accessor :name, :funds, :tickets_bought

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
    @tickets_bought = options['tickets_bought'].to_i

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
        funds,
        tickets_bought
      ) VALUES (
        $1,
        $2,
        $3
        )
        RETURNING *'
      values = [@name, @funds, @tickets_bought]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
      sql = 'UPDATE customers SET (
       name,
       funds,
       tickets_bought
       ) = (
          $1,
          $2,
          $3
            )
        WHERE id = $4
        '
        values = [@name,@funds,@tickets_bought, @id]
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

    def deduct_money(screening)
      sql = 'SELECT films.price
            FROM films
            WHERE films.id = $1'
      values = [screening.film_id.to_i]
      film_price = SqlRunner.run(sql, values)[0]['price'].to_i
      return @funds -= film_price
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
      deduct_money(screening)
      @tickets_bought += 1
      update()
    end

    def check_tickets_bought
      sql = 'SELECT * FROM tickets
            WHERE customer_id = $1'
      values = [@id]
      return result = SqlRunner.run(sql, values).count
    end






end
