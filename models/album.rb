require('pg')
require_relative('artist')

class Album
  attr_reader(:id, :name, :artist_id, :album_link_id)
  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @artist_id = options['artist_id'].to_i
    @album_link_id = options['album_link_id']
  end

  def save()
    sql = "INSERT INTO albums (name, artist_id, album_link_id) VALUES ('#{@name}', '#{@artist_id}', '#{@album_link_id}') RETURNING *"
    album_info = run_sql(sql)
    @id = album_info.first['id'].to_i
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = #{@artist_id}"
    artist_data = run_sql(sql)
    artist = Artist.new(artist_data.first)
    return artist
  end

  def self.all()
    sql = "SELECT * FROM albums"
    album_data = run_sql(sql)
    albums = album_data.map{|album| Album.new(album)}
    return albums
  end

  def self.find(id)
  sql = "SELECT * FROM albums WHERE id='#{id}'"
  albums=run_sql(sql)
  album = albums.map{|album| Album.new(album)}
  return album.first
  end


  def self.update(options)
    sql = "UPDATE albums SET name = '#{options['name']}', album_link_id = '#{options['album_link_id']}' WHERE id = '#{options['id']}'"
    run_sql(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM albums WHERE id = '#{id}'"
    run_sql(sql)
  end

  def self.search(text)
    sql = "SELECT * FROM albums WHERE name LIKE '%#{text}%'"
    albums = run_sql(sql)
    results = albums.map{|album| Album.new(album)}
    return results
  end

end