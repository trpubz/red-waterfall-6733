require "rails_helper"
require_relative "../../app/poros/character"

describe AirbenderFacade do
  xit "creates characters upon init", :vcr do
    af = AirbenderFacade.new

    expect(af.characters.first).to be_a Airbender::Character
  end
end
