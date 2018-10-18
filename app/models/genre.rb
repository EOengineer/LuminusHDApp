class Genre < ApplicationRecord
	include Gridable, Sortable, Searchable, Paginateable

  search_attributes includes: [
    'title'
  ]

	has_many :album_genres
	has_many :albums, through: :album_genres

	validates :title, presence: true
end
