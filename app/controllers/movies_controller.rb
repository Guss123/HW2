class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
  
  def updateform
  end
  def custupdate 
    @guss = Movie.find_by(title: params[:movie][:origtitle])
    if (@guss == nil)
      @lol = "No Such title"
    else 
      @guss.update_attributes!(movie_params.reject{|k,v| v.blank?})
      flash[:notice] = "#{@guss.title} was successfully updated."
      redirect_to movies_updateform_path
    end
    
  end
  
  def delform
  end
  
  def custdel
    if params[:choose][:tr] == 'title'
      @guss = Movie.where(title: params[:movie][:query])
    else 
      @guss = Movie.where(rating: params[:movie][:query])
    end
    if (@guss == nil)
      @lol = 'No such movie(s)'
    else
    @guss.destroy_all
    redirect_to movies_path
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    if params[:sort_param] == "title" || params[:sort_param] == "release_date"
    @movies = Movie.all.order("#{params[:sort_param]} ASC")
    else
    @movies = Movie.all
    end
    @styl = "hilite"
    @all_ratings = Movie.all_ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
