class SongsController < ApplicationController

  before_action :ensure_logged_in
  skip_before_action :ensure_logged_in, only: [:index, :show]

  # Show all songs (optionally those owned by a particular user)
  def index
    if params[:user_id]
      @owner = User.find(params[:user_id])
      @songs = Song.where(:user => @owner)
    else
      @songs = Song.all
    end
  end

  def show
    @song = Song.find(params[:id])

    # Handle 404
  end

  # Start creating a new song
  def new
    @song = Song.new

    render "edit"
  end

  # Add a song
  def create
    @song = Song.new(song_params.merge(:user => current_user))
    @song.artist = Artist.find_or_create(params.permit(:artist)[:artist])
    @song.save

    # Add flash notice

    redirect_to @song

    # Rescue errors
  end

  # Start editing an existing song
  def edit
    @song = Song.where(:user => current_user).find(params[:id])
    # Handle 404
  end

  # Update a song
  def update
    @song = Song.where(:user => current_user).find(params[:id])
    @song.update_attributes(song_params)

    # Add flash notice

    redirect_to @song

    # Rescue errors
  end

  # Delete a song
  def delete
    @song = Song.where(:user => current_user).find(params[:id])
    @song.destroy

    # Add flash notice
    redirect_to songs_path

    # Rescue errors
  end

  private

  def song_params
    params[:song].permit(:name, :body)
  end
end
