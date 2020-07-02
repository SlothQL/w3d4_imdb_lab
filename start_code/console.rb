require_relative('models/movie')
require_relative('models/star')
require_relative('models/casting')

require('pry-byebug')

Movie.delete_all()
Star.delete_all

movie1 = Movie.new({
    'title' =>'Into The Wild',
    'genre' => 'drama'
})
movie1.save()

movie1.genre = 'survival'
movie1.update()

star1 = Star.new( {
    'first_name' => "Ben",
    'last_name' => "Affleck"
})
star1.save()

binding.pry
nil