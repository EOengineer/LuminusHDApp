require_relative '../helpers/data_factory.rb'

namespace :setup do
  desc "This task initializes the db with some seed data"
  task :create_demo_data => :environment do

  	puts "resetting database"
		Administrator.destroy_all
		Label.destroy_all
		Genre.destroy_all
		Album.destroy_all
		AlbumArtist.destroy_all
		AlbumGenre.destroy_all
		Artist.destroy_all
		Track.destroy_all




		# Admins
		puts "created admins..."
		generic_pw = 'Password123!'

		Administrator.create!({
			first_name: 'Dan',
			last_name: 'Shores',
			email: 'dshores@sonoluminus.com',
			password: generic_pw,
			password_confirmation: generic_pw
		})

		Administrator.create!({
			first_name: 'Eric',
			last_name: 'Oligney',
			email: 'eoengineer@gmail.com',
			password: generic_pw,
			password_confirmation: generic_pw
		})

		puts "creating artists"
		@artists = Artist.create!(DataFactory::Artists.manifest(10))

		puts "creating labels"
		@labels = Label.create!(DataFactory::Labels.manifest)

		puts "creating genres"
		@genres = Genre.create!(DataFactory::Genres.manifest)


		puts "creating albums..."

		@albums = DataFactory::Albums.manifest(100)

		Artist.all.to_a.each_with_index do |artist, i|
			
			start_range = i * 10
			end_range		= i == 0 ? start_range + 10 : start_range + 9
			(@albums[start_range..end_range]).each_with_index do |album, a_i|

			# @albums.each do |album|
				album = Album.new(album)
				album.artist_id = artist.id
				album.label  = @labels.to_a[i]
				album.album_genres.build(genre: @genres.sample)
				album.album_artists.build(artist: @artists.sample)
				album.save!
			end

		end

		

  end
end