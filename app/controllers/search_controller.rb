class SearchController < ApplicationController
  def index
    @nation = params[:nation].split("+").map(&:capitalize).join(" ")
    @characters = AirbenderFacade.new.characters_by_affiliation(params[:nation])
  end
end
