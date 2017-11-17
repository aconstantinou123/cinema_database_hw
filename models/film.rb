require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

    def self.delete_all()
      sql = 'DELETE FROM films'
      SqlRunner.run(sql)
    end

    def self.list_all
      sql = 'SELECT * FROM films'
      films = SqlRunner.run(sql)
      return films.map {|film| Film.new(film)}
    end

    def save()
      sql = 'INSERT INTO films (
        title,
        price
      ) VALUES (
        $1,
        $2
        )
        RETURNING *'
      values = [@title, @price]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
      sql = 'UPDATE films SET (
       title,
       price
       ) = (
          $1,
          $2
            )
        WHERE id = $3
        '
        values = [@title,@price, @id]
        SqlRunner.run(sql, values)
    end

end
