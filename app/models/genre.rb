class Genre < ApplicationRecord
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

	has_many :album_genres
	has_many :albums, through: :album_genres

	validates :title, presence: true
end
