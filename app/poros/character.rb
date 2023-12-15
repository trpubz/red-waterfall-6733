module Airbender
  class Character
    attr_reader :id, :name, :affiliation, :allies, :enemies, :photo_url
    def initialize(attrs)
      @id = attrs[:_id]
      @name = attrs[:name]
      @affiliation = attrs[:affiliation]
      @allies = attrs[:allies]
      @enemies = attrs[:enemies]
      @photo_url = attrs[:photoUrl]
    end
  end
end
