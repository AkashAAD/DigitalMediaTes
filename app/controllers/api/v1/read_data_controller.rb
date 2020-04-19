class Api::V1::ReadDataController < ApplicationController
  before_action :is_authenticated
  skip_before_action :verify_authenticity_token

  def movies
    render json: { movies: all_movies }, status: :ok
  end

  def seasons
    render json: { seasons: all_seasons }, status: :ok
  end

  def movies_seasons
    movies_seasons = { movies: all_movies, seasons: all_seasons }
    render json: { movies_seasons: movies_seasons }, status: :ok
  end

  def user_library
    render json: { user_libraries: user_libraries }, status: :ok
  end

  def movie_season
    render json: { movie_season_data: params[:type].titleize.constantize.all }, status: :ok
  end

  def movie_season_option
    render json: { movie_season_data: params[:type].titleize.constantize.find_by(id: params[:id]).options }, status: :ok
  end

  def movie_season_option
    render json: { movie_season_data: params[:type].titleize.constantize.find_by(id: params[:id]).options }, status: :ok
  end

  private
  def all_movies
    Movie.all.order(:created_at)
  end

  def all_seasons
    Season.all.as_json(include: [:episodes])
  end

  def user_libraries
    @user.libraries.where("DATE(created_at) <= ?", Date.today + 3.days).order(:created_at).as_json(include: [:contentable])
  end  

end
