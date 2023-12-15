class SearchController < ApplicationController
  def index
    @nation = params[:nation].split("+").map(&:capitalize).join(" ")

    af = Rails.cache.read("airbender")
    @characters = if af.nil?
      AirbenderFacade.new.characters_by_affiliation(params[:nation])
    else
      af.characters_by_affiliation(params[:nation])
    end
  end
end
