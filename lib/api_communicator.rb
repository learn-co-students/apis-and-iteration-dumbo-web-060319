require 'rest-client'
require 'json'
require 'pry'


def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get("http://www.swapi.co/api/people/?search=#{character_name}")
  response_hash = JSON.parse(response_string)

  films_array = []
  response_hash["results"].each do |character_hash| 
    if character_hash["name"].downcase == character_name.downcase
      films_array << character_hash["films"]
      films_array.flatten
    end 
  end
  
  my_array=[]
  films_array.each do |film|
    var = RestClient.get(film)
    var_hash= JSON.parse(var)
    my_array.push(var_hash)
  end 

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end
binding.pry


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film|
    response_film = RestClient.get(film)
    film_hash = JSON.parse(response_film)
    puts "Title: #{film_hash["title"]} Description: #{film_hash["opening_crawl"]}"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
