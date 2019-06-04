require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # Array of Film Character Hashes
  film_collection = response_hash["results"]

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`

  # Single Character Hash
  character = film_collection.find do |character_hash|
    
    if character_hash["name"] == character_name
      character_hash
    end
  end

  # Charters Films
  character_films = character["films"] 

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  # Store all the films in this array
  film_collection = []

  all_film_details = character_films.each do |film|   
    film_collection << JSON.parse(RestClient.get(film))
  end
  
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.

  film_collection
end



def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  titles = []
  films.each do |film|
    titles << film["title"]
  end
  binding.pry
  titles.sort
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
