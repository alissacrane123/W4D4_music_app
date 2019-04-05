class BandsController < ApplicationController
    def index
        @bands = Band.all 
        render :index 
    end

    def show
        @band = Band.find(params[:id])
        render :show 
    end 

    def create 
        @band = Band.new(band_params)

        if @band.save
            redirect_to band_url(@band)
        else 
            render json: @band.errors.full_messages
        end 
    end 

    def destroy
        @band = Band.find(params[:id])

        if @band 
            @band.destroy 
            redirect_to bands_url 
        else 
            render json: "that band doesn't even exist"
        end 
    end 

    def band_params
        params.require(:band).permit(:name)
    end
end
