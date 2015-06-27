CONNECTION = SQLite3::Database.new("music-library.db")

CONNECTION.results_as_hash = true

CONNECTION.execute("CREATE TABLE IF NOT EXISTS music_collections (id INTEGER PRIMARY KEY, band_name TEXT NOT NULL, album_name TEXT, media_type_id INTEGER, location_id INTEGER NOT NULL);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS media_types (id INTEGER PRIMARY KEY, type TEXT);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, name TEXT);")
