require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('./models/artist')
require_relative('./models/album')

get '/library' do
@artists = Artist.all()
erb(:index)
end

get '/artist/new' do
erb(:new_artist)
end

get '/artist/:id' do
@artist=Artist.find(params[:id])
erb(:show_artist)
end

post '/artist' do
@artist = Artist.new(params)
@artist.save()
erb(:create_artist)
end

get '/album/new' do
@artists = Artist.all()
erb(:new_album)
end

post '/album' do
@album = Album.new(params)
@album.save()
erb(:create_album)
end

get '/album/:id/edit' do
@album=Album.find(params[:id])
erb(:edit_album)
end

post '/album/:id' do
  Album.update(params)
  redirect to ('/library')
end

get '/album/:id/delete' do
Album.delete(params[:id])
redirect to ('/library')
end


get '/artist/:id/edit' do
@artist=Artist.find(params[:id])
erb(:edit_artist)
end

post '/artist/:id' do
  Artist.update(params)
  redirect to ('/library')
end

get '/artist/:id/delete' do
@artist=Artist.delete(params[:id])
redirect to ('/library')
end

