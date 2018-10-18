class Admin::AlbumsController < Admin::BaseController
	include GridController
	include SortController
	include PaginationController
	

	def index
		@query = @resource.includes(:artist, :label)
							.search_columns(params[:q])
							.sorted(@sort_field, @sort_direction)
							.paginated(@current_page, @per_page)
		
		add_breadcrumb "Albums", :admin_albums
	end



	def new
		@album = Album.new
		add_breadcrumb "Albums", :admin_albums
		add_breadcrumb "New", :new_admin_album
	end


	def create
		add_breadcrumb "Albums", :admin_albums
		add_breadcrumb "New", :new_admin_album
		
		@album = Album.create(album_params)

		if @album.save
			flash[:success] = "Album successfully created."
			redirect_to admin_albums_path
		else
			render :new
		end
	end

	def edit
		add_breadcrumb "Albums", :admin_albums
		add_breadcrumb "Edit", :edit_admin_album
		@album = Album.find(params[:id])
	end

	def update
		add_breadcrumb "Albums", :admin_albums
		add_breadcrumb "Edit", :edit_admin_album

		@album = Album.find(params[:id])

		if @album.update(album_params)
			flash[:success] = "Album successfully updated."
			redirect_to edit_admin_album_path(@album)
		else
			render :edit
		end
	end



	private

	def album_params
		params.require(:album).permit(:title, :description, :release_date, :artist_id, :label_id, :available, :cover_image, album_art_images: [], artist_ids: [])
	end

end