class AirbenderFacade
  attr_reader :characters
  def initialize
    data = Api::AirbenderService.characters[:data]
    @characters = data.map { |char| Airbender::Character.new(char) }
  end

  def character(name)
    data = Api::AirbenderService.character(name)
  end
end
