class CreateAlbumGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :album_genres do |t|
      t.references :album, foreign_key: true
      t.references :genre, foreign_key: true

      t.timestamps
    end
  end
end
