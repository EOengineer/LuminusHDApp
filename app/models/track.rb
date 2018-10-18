class Track < ApplicationRecord
	include Gridable, Sortable, Searchable, Paginateable

	search_attributes includes: [
    'title',
    'time',
    'single',
    'position',
    'album'
  ]

	belongs_to :album

  acts_as_list scope: :album

  validates :title, presence: true
end
