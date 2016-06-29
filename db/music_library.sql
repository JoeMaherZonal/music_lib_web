DROP TABLE albums;
DROP TABLE artists;

CREATE TABLE artists (
id SERIAL4 primary key,
name VARCHAR(255),
image_link VARCHAR(255)
);

CREATE TABLE albums (
id SERIAL4 primary key,
artist_id INT4 references artists(id) on delete cascade,
name VARCHAR(255),
album_link_id INT4
);