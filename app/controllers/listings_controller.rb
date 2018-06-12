class ListingsController < ApplicationController
    load_and_authorize_resource
    def index
        @listings = Listing.all.paginate(page: params[:page])
    end

    def new # show form for a new listing
        @listing = Listing.new
    end

    def create # gets the information submitted by form in #new
        @listing = current_user.listings.new(listing_params)
        if @listing.save
            redirect_to listings_path
        else
            render "new"
        end
    end

    def edit # show form for editing a listing
        @listing = Listing.find(params[:id])
    end

    def update
        @listing = Listing.find(params[:id])
        if @listing.update(listing_params)
            redirect_to listing_path(@listing)
        else
            render "edit"
        end
    end 

    def show
        @listing = Listing.find(params[:id])
    end

    def destroy
        @listing = Listing.find(params[:id])
        @listing.destroy
        redirect_to listings_path
    end

    private
    def listing_params
        params.require(:listing).permit(:name, :description, :property_type, :price, :address, :city, :state)
    end
end
