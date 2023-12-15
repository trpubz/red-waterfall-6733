require_relative "../poros/character"

# Facade is stored in memory store, on initialization characters array is instantiated
class AirbenderFacade
  attr_reader :characters
  def initialize
    @characters = []
  end

  # def character(name)
  #   data = Api::AirbenderService.character(name)
  #   add_characters(data)
  # end

  # @param affiliation [String] ex: "fire+nation", requires conversion to match Character attributes
  # @return [Characters] a subset of characters matching the normalized affiliation
  # @abstract Before making an API call, check if any existing characters already match.  The criteria is affiliation match,
  #   but also no enemies match. "A house divided"...if those characters do exist, select them from the collection.
  #   If not, make a new API call, add them to collection and update cache.
  def characters_by_affiliation(affiliation)
    norm_affiliation = affiliation_normalization(affiliation)
    if @characters.any? { |c| c.affiliation.include?(norm_affiliation) && !c.enemies.include?(norm_affiliation) }
      return @characters.select { |c| c.affiliation.include?(norm_affiliation) }
    else
      data = Api::AirbenderService
        .characters_affiliation(affiliation)[:data]
      return add_characters(data)  # returns the nation characters
    end
  end

  private

  def add_characters(data)
    nation_characters = []

    data.each do |char|
      unless @characters.any? { |c| c.id == char[:_id] }
        c = Airbender::Character.new(char)
        @characters << c
        nation_characters << c
      end
    end
    # update cache when new characters are added to the facade collection
    Rails.cache.write("airbender", self)
    nation_characters
  end

  def affiliation_normalization(affiliation)
    affiliation.split("+").map(&:capitalize).join(" ")
  end
end


