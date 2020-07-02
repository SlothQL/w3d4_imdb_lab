require_relative('../db/sql_runner')

class Movie

    attr_reader :id
    attr_accessor :title, :genre, :budget

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @title = options['title']
        @genre = options['genre']
        @budget = options['budget'].to_i
    end


def save()
        sql = "INSERT INTO movies
        (title, genre) VALUES ($1, $2) RETURNING id"
        values = [@title, @genre]
        user = SqlRunner.run(sql, values).first
        @id = user['id'].to_i
    end

    def self.all()
        sql = "SELECT * FROM movies"
        data = SqlRunner.run(sql)
        return data.map {|movie| Movie.new(movie)}
    end

    def update()
        sql = "UPDATE movies SET (title, genre) = ($1, $2)
        WHERE id = $3"
        values = [@title, @genre, @id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = "DELETE FROM movies"
        SqlRunner.run(sql)
    end

    def stars()
        sql = "SELECT stars.* FROM stars
        INNER JOIN castings ON
        castings.star_id = stars.id WHERE movie_id = $1"
        values = [@id]
        stars = SqlRunner.run(sql, values)
        return stars.map { |star| Star.new(star) }
    end

    def castings()
        sql = "SELECT * FROM castings
        WHERE movie_id = $1"
        values = [@id]
        casting_data = SqlRunner.run(sql, values)
        return casting_data.map { |casting| Casting.new(casting) }
    end

    def remaining_budget()
        castings = self.castings()
        casting_fees = castings.reduce(0) { |total, casting| total += casting.fee}
        return @budget -= casting_fees 
    end


end
