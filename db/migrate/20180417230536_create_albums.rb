class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.datetime :release_date
      t.references :artist, index: true
      t.references :label, index: true
      t.boolean :available, default: false

      t.timestamps
    end
    add_index :albums, [:title, :artist_id], unique: true
  end
end
