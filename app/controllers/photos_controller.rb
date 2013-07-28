class PhotosController < ApplicationController
  
  respond_to :json

    def index
      lat, lng = params[:latitude], params[:longitude]
      if lat and lng
        @photos = Photo.nearby(lat.to_f, lng.to_f)
        respond_with({:photos => @photos})
      else
        respond_with({:message => "Invalid or missing latitude/longitude parameters"}, :status => 406)
      end
    end

    def show
      @photo = Photo.find(params[:id])
      respond_with(@photo)
    end

    def create
      @photo = Photo.create(params[:photo])
      respond_with(@photo)
    end
  
end
