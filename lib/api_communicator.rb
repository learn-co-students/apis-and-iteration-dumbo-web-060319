require 'rest-client'
require 'json'
require 'pry'

def find_character_in_list(response_hash)
  response_hash["results"][0]
end

def get_films_from_hash(character_hash)
  character_hash["films"]
end

def film_info(films_url_array)
  films = []
  films_url_array.each do |film|
    response_string = RestClient.get(film)
    films << JSON.parse(response_string)
  end

  films
end

def get_character_movies_from_api(character_name)
  url = "http://www.swapi.co/api/people/?search=#{character_name}"
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)

  character_hash = find_character_in_list(response_hash)
  films_url_array = get_films_from_hash(character_hash)

  film_info(films_url_array)
end

def print_movies(films)
  films.each {|film| puts film["title"]}
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
