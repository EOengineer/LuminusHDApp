class Admin::ArtistsController < Admin::BaseController
	include GridController

	def new
		@artist = Artist.new
		add_breadcrumb "Artists", :admin_artists
		add_breadcrumb "New", :new_admin_artist
	end


	def create
		@artist = Artist.create(artist_params)

		if @artist.save
			flash[:success] = "Artist successfully created."
			redirect_to admin_artists_path
		else
			render :new
		end
	end

	def edit
		add_breadcrumb "Artists", :admin_artists
		add_breadcrumb "Edit", :edit_admin_artist
		@artist = Artist.find(params[:id])
	end

	def update
		@artist = Artist.find(params[:id])

		if @artist.update(artist_params)
			flash[:success] = "Artist successfully updated."
			redirect_to edit_admin_artist_path(@artist)
		else
			render :edit
		end
	end



	private

	def artist_params
		params.require(:artist).permit(:title)
	end

end