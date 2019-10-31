class SightingsController < ApplicationController

    def index
        sightings = Sighting.all
        if sightings != []
            render json: sightings.to_json(:include => {
                :bird => {only: [:name, :species]},
                :location => {only: [:latitude, :longitude]}
            }, except: [:updated_at])
        else
            render json: {message: "No sightings found"}
        end
    end

    def show
        sighting = Sighting.find_by(id: params[:id])
        if sighting
            render json: sighting, include: [:bird, :location], except: [:updated_at]
        else
            render json: {message: "No sighting found"}
        end
    end
end
