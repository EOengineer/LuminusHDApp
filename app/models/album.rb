class Album < ApplicationRecord
  include Gridable, Sortable, Searchable, Paginateable

  search_attributes includes: [
    'albums.title',
    'available',
    'release_date',
    'artists.title',
    'labels.title'
  ]

  grid_attributes includes: [
    'id',
    'title',
    'release_date',
    'artist',
    'label',
    'available'
  ]

	belongs_to :artist, class_name: 'Artist'
  belongs_to :label

  has_one_attached :cover_image
  has_many_attached :album_art_images

  has_many :album_artists
  has_many :artists, through: :album_artists

  has_many :tracks, dependent: :nullify

  has_many :album_genres
  has_many :genres, through: :album_genres

  validates :title,
            :description, presence: true

  validates :title, uniqueness: { scope: :artist }

  scope :with_associations, -> { includes(:artist, :label) }
  scope :available, -> { where(available: true) }
  scope :new_releases, -> (days) { where('release_date >= ?', days.days.ago) }
  scope :recently_added, -> { where('created_at >= ?', 14.days.ago) }
  
end
