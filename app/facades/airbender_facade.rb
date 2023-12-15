require_relative "../poros/character"
class AirbenderFacade
  attr_reader :characters
  def initialize
    @characters = []
  end

  def character(name)
    data = Api::AirbenderService.character(name)
    add_characters(data)
  end

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

    Rails.cache.write("airbender", self)
    nation_characters
  end

  def affiliation_normalization(affiliation)
    affiliation.split("+").map(&:capitalize).join(" ")
  end
end


