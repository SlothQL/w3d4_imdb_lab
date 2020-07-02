require_relative('models/movie')
require_relative('models/star')
require_relative('models/casting')

require('pry-byebug')

Casting.delete_all()
Movie.delete_all()
Star.delete_all



movie1 = Movie.new({
    'title' =>'Into The Wild',
    'genre' => 'drama',
    'budget' => 5000000
})
movie1.save()

movie1.genre = 'survival'
movie1.update()

star1 = Star.new( {
    'first_name' => "Ben",
    'last_name' => "Affleck"
})
star1.save()

star2 = Star.new( {
    'first_name' => "Kirsten",
    'last_name' => "Stewart"
})
star2.save()


casting1 = Casting.new({
    'movie_id' => movie1.id,
    'star_id' => star2.id,
    'fee' => '1000'
})
casting1.save()

binding.pry
nil