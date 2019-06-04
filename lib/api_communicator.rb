require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  # response_string = RestClient.get('http://www.swapi.co/api/people/')
  # response_hash = JSON.parse(response_string)
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  response_string2=RestClient.get("http://www.swapi.co/api/people/?search=#{character_name}")
  parsed = JSON.parse(response_string2)
  if parsed["count"] == 0
    return nil
  else 

    newArr=[]
    allFilms= parsed["results"][0]["films"]
    newArr = newArr + allFilms

    newFinalArr=[]
    counter = 0 
    while ( counter < newArr.size)
      r= RestClient.get(newArr[counter])
      s= JSON.parse(r)
      newFinalArr.push(s)
      counter = counter + 1
    end 
    return newFinalArr
  end 

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films=nil)
  # some iteration magic and puts out the movies in a nice list
  if films == nil
    puts "Sorry! Not Found!!"
    return nil
  end 
  x=films 
  counter = 0

  while ( counter < x.length)
    y= films[counter]
    z=y["title"]
    puts "--------------"
    puts z 
    
    counter = counter + 1
  end 
end
def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS


# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
