require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('./models/artist')
require_relative('./models/album')
require_relative('./artist_controller')
require_relative('./album_controller')

get '/' do
  @artists = Artist.all()
  @albums = Album.all()
erb(:home)
end

get '/search' do
  @artists = Artist.all()
  @albums = Album.all()
  erb(:search)
end

