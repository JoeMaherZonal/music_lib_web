require( 'pg' )
require_relative('../db/sql_runner')
require_relative('album')

class Artist
  attr_reader(:name, :id)
  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @albums = []
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING *"
    artist_info = run_sql(sql)
    @id = artist_info.first['id'].to_i
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = #{@id}"
    albums = run_sql(sql)
    album_array = albums.map {|album| Album.new(album)}
    return album_array
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists_data = run_sql(sql)
    artists = artists_data.map{|artist| Artist.new(artist)}
    return artists
  end

  def self.find(id)
  sql = "SELECT * FROM artists WHERE id='#{id}'"
  artist=run_sql(sql)
  artists = artist.map{|artist| Artist.new(artist)}
  return artists.first
  end

  def self.update(options)
    sql = "UPDATE artists SET name = '#{options['name']}' WHERE id = '#{options['id']}'"
    run_sql(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM artists WHERE id = '#{id}'"
    run_sql(sql)
  end

end

