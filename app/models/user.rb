class User < ApplicationRecord
	include Gridable, Sortable, Searchable, Paginateable

  search_attributes includes: [
    'id',
    'email',
    'created_at',
    'updated_at'
  ]

  grid_attributes includes: [
  	'id',
  	'email',
  	'created_at',
  	'updated_at'
  ]
  
	has_secure_password
	has_one_attached :avatar
	
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
end
