class Api::V1::DigitalContentController < ApplicationController
  before_action :is_authenticated
  before_action :allow_admin_only, only: [:create_movie, :create_season, :create_episode]
  skip_before_action :verify_authenticity_token

  def create_movie
    movie = Movie.new(movie_params)
    if movie.save
      render json: { message: "Movie created successfully." }, status: :created
    else
      render json: { message: movie.errors.full_messages.join(', ') }, status: :not_acceptable
    end
  end

  def create_season
    season = Season.new(season_params)
    if season.save
      render json: { message: "Season created successfully." }, status: :created
    else
      render json: { message: season.errors.full_messages.join(', ') }, status: :not_acceptable
    end
  end

  def create_episode
    episode = Episode.new(episode_params)
    if episode.save
      render json: { message: "Episode created successfully." }, status: :created
    else
      render json: { message: episode.errors.full_messages.join(', ') }, status: :not_acceptable
    end
  end

  def create_option
    option = digital_content.options.new(option_params)
    if option.save
      render json: { message: "Option created successfully." }, status: :created
    else
      render json: { message: option.errors.full_messages.join(', ') }, status: :not_acceptable
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :plot)
  end

  def season_params
    params.require(:season).permit(:title, :plot, :no_of_edposodes)
  end

  def episode_params
    params.require(:episode).permit(:title, :plot, :season_id)
  end

  def option_params
    params.require(:option).permit(:price, :video_quality)
  end

  def allow_admin_only
    unless @user.role.name.eql?('admin')
      render json: { message: 'Only admin can create movies, seasons or episodes' }, status: :not_acceptable
    end
  end

  def digital_content
    params[:option][:type].titleize.constantize.find_by(id: params[:option][:movie_season_id])    
  end

end
