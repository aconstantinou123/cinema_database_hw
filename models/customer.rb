require_relative("../db/sql_runner")

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

end
