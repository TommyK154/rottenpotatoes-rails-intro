class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    @all_ratings = Movie.all_ratings
    @ratings_filter = @all_ratings

=begin  
    #unless params[:sort] @sort = session[:sort]
    #unless params[:ratings] @ratings_filter = session[:ratings]
    
    
    if params[:sort]
      @sort = params[:sort]
      #session[:sort] = @sort
    end
    
    if params[:ratings]
      @ratings_filter = params[:ratings].keys
      #session[:ratings] = @ratings_filter
    end
=end

    if (params[:ratings]) # and params[:commit] == 'Refresh')
        @ratings_filter = params[:ratings].keys
    elsif params[:ratings]
        @ratings_filter = params[:ratings]
    else
        @ratings_filter = session[:ratings] || @all_ratings
    end

    @sort = params[:sort] || session[:sort]

    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
        session[:ratings] = @ratings_filter
        session[:sort] = @sort
        redirect_to movies_path :sort => @sort, :ratings => @ratings_filter and return
    end
    
    @movies = Movie.sort_by_and_rating(@sort, @ratings_filter)

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
