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
    data = Api::AirbenderService
      .characters_affiliation(affiliation)[:data]
    add_characters(data)  # returns the nation characters
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

    nation_characters
  end
end
