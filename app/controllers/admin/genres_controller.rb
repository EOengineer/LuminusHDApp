class Admin::GenresController < Admin::BaseController
	include GridController

	def new
		@genre = Genre.new
		add_breadcrumb "Genres", :admin_genres
		add_breadcrumb "New", :new_admin_genre
	end


	def create
		@genre = Genre.create(genre_params)

		if @genre.save
			flash[:success] = "Genre successfully created."
			redirect_to admin_genres_path
		else
			render :new
		end
	end

	def edit
		add_breadcrumb "Genres", :admin_genres
		add_breadcrumb "Edit", :edit_admin_genre
		@genre = Genre.find(params[:id])
	end

	def update
		@genre = Genre.find(params[:id])

		if @genre.update(genre_params)
			flash[:success] = "Genre successfully updated."
			redirect_to edit_admin_genre_path(@genre)
		else
			render :edit
		end
	end



	private

	def genre_params
		params.require(:genre).permit(:title)
	end

end