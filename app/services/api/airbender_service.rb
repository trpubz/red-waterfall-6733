class Api::AirbenderService
  def self.characters
    response = conn.get("/api/v1/characters?perPage=500")

    response_conversion(response)
  end

  def self.characters_by_name(name)
    response = conn.get("/api/v1/characters?name=#{name}")

    response_conversion(response)
  end

  def self.characters_affiliation(name)
    response = conn.get("/api/v1/characters?affiliation=#{name}")

    response_conversion(response)
  end

  def self.characters_enemies(name)
    response = conn.get("/api/v1/characters?enemies=#{name}")

    response_conversion(response)
  end

  def self.characters_allies(name)
    response = conn.get("/api/v1/characters?allies=#{name}")

    response_conversion(response)
  end

  def self.conn
    Faraday.new("https://last-airbender-api.fly.dev")
  end

  def self.response_conversion(response)
    {status: response.status, data: JSON.parse(response.body, symbolize_names: true)}
  end
end
