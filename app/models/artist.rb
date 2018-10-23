class Artist < ApplicationRecord
	include Gridable, Sortable, Searchable, Paginateable

	search_attributes includes: [
    'id',
    'title',
    'created_at',
    'updated_at'
  ]

  grid_attributes includes: [
    'id',
    'title',
    'created_at',
    'updated_at'
  ]

	has_many :album_artists
	has_many :albums, through: :album_artists

	validates :title, presence: true
end
