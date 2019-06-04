require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  result = []
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)



  # iterate over the response hash to find the collection of `films` for the given
  #   `character`

  films = response_hash["results"][0]["films"]
  films.each do |film_url|
    result << film_api_helper(film_url) 
  end
  
  return result

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

def print_movies(films)
  films.each do |film_hash|
    puts "--"*10
    puts "Title:"
    puts film_hash["title"]
    puts "Description"
    puts film_hash["opening_crawl"]
  end

end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end


get_character_movies_from_api("samip")
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?


def film_api_helper(url)
response_string=RestClient.get url
response_hash=JSON.parse(response_string)
end

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
