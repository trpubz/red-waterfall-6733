class SearchController < ApplicationController
  def index
    @nation = params[:nation].split("+").map(&:capitalize).join(" ")

    # check to see if Facade exists in cache
    af = Rails.cache.read("airbender")
    @characters = if af.nil?
      AirbenderFacade.new.characters_by_affiliation(params[:nation])
    else
      af.characters_by_affiliation(params[:nation])
    end
  end
end
