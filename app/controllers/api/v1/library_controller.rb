class Api::V1::LibraryController < ApplicationController
  before_action :is_authenticated
  before_action :duplicate_library, only: [:create_library]
  skip_before_action :verify_authenticity_token

  def create_library
    library = digital_content.libraries.new(library_params)
    library.user_id = @user.id
    if library.save
      render json: { message: "#{digital_content.title} purchased successfully." }, status: :created
    else
      render json: { message: library.errors.full_messages.join(', ') }, status: :not_acceptable
    end
  end

  private
  def library_params
    params.require(:library).permit(:option_id)
  end

  def digital_content
    params[:library][:type].titleize.constantize.find_by(id: params[:library][:movie_season_id])    
  end

  def duplicate_library
    unless Library.find_by(option_id: library_params[:option_id], user_id: @user.id, contentable_type: params[:library][:type].titlecase, contentable_id:  params[:library][:movie_season_id]).nil?
      render json: { message: "Duplicate purchase does't allow." }, status: :not_acceptable
    end
  end

end
