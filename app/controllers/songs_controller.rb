class SongsController < ApplicationController

  # Show all songs
  def index
    @songs = Song.all
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
    @song = Song.new(song_params)
    @song.artist = Artist.find_or_create(params.permit(:artist)[:artist])
    @song.save

    # Add flash notice

    redirect_to @song

    # Rescue errors
  end

  # Start editing an existing song
  def edit
    @song = Song.find(params[:id])
    # Handle 404
  end

  # Update a song
  def update
    @song = Song.find(params[:id])
    @song.update_attributes(song_params)

    # Add flash notice

    redirect_to @song

    # Rescue errors
  end

  # Delete a song
  def delete
    @song = Song.find(params[:id])
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
