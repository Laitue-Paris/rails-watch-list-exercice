require "json"
require "open-uri"


puts "cleanup"
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts "done with chore.."

puts "lets create the movies"

IMAGE_URL = "https://image.tmdb.org/t/p/original"
TMVB_WAGON_URL ="https://tmdb.lewagon.com/movie/top_rated"

movies_serialized = URI.parse(TMVB_WAGON_URL).read
movies = JSON.parse(movies_serialized)["results"]

movies.each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "#{IMAGE_URL}#{movie["backdrop_path"]}.jpg",
    rating: movie["vote_average"]
  )
end

puts "now the lists"
movies = Movie.all.to_a

%w[top flop batch-2362].each do |name|
  list = List.create!(name: name)
  available = movies.dup

  rand(2..6).times do
    movie = available.delete(available.sample)
    Bookmark.create!(comment: "Lorem Ipsum", movie: movie, list: list)
  end
end

List.all.each do |list|
  list.update(poster_url: list.movies.pluck(:poster_url).sample)
end
puts "#{Movie.count} créés"
puts "#{List.count} créées"
puts "#{Bookmark.count} créés"
