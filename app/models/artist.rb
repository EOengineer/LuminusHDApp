class Artist < ApplicationRecord
	include Gridable, Sortable, Searchable, Paginateable

	search_attributes includes: [
    'title'
  ]

	has_many :album_artists
	has_many :albums, through: :album_artists

	validates :title, presence: true
end
