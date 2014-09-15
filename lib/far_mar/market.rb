module FarMar
  class Market
    attr_accessor :id, :name, :address, :city, :county, :state, :zip

    def initialize(market_array)
      @id = market_array[0].to_i
      @name = market_array[1]
      @address = market_array[2]
      @city = market_array[3]
      @county = market_array[4]
      @state = market_array[5]
      @zip = market_array[6]
    end

    def self.all
      markets = []
      CSV.read("support/markets.csv").each do |market|
        markets << FarMar::Market.new(market)
      end
      markets
    end

    def self.find(id)
      markets = self.all
      markets.find {|market| market.id == id}
    end


  end

end
