class Admin::TracksController < Admin::BaseController
	include GridController

	def new
		@track = Track.new
		add_breadcrumb "Tracks", :admin_tracks
		add_breadcrumb "New", :new_admin_track
	end


	def create
		@track = Track.create(track_params)

		if @track.save
			flash[:success] = "Track successfully created."
			redirect_to admin_tracks_path
		else
			render :new
		end
	end

	def edit
		add_breadcrumb "Tracks", :admin_tracks
		add_breadcrumb "Edit", :edit_admin_tracks
		@track = Track.find(params[:id])
	end

	def update
		@track = Track.find(params[:id])

		if @track.update(track_params)
			flash[:success] = "Track successfully updated."
			redirect_to edit_admin_track_path(@artist)
		else
			render :edit
		end
	end



	private

	def artist_params
		params.require(:track).permit(:title, :time, :single, :description, :position, :album_id)
	end

end