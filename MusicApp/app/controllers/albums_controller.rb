class AlbumsController < ApplicationController

    def show
        @album = Album.find(params[:id])
        render :show 
    end 

    def new 
        @album = Album.new 
    end 

    def create  
        @album = Album.new(album_params)

        if @album.save
            redirect_to album_url(@album)
        else 
            render json: @album.errors.full_messages 
        end 
    end 

    private 

    def album_params 
        params.require(:album).permit(:title, :year, :band_id, :live)
    end 
end
