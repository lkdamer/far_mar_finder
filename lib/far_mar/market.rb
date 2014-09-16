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
      CSV.read("./support/markets.csv").each do |market|
        markets << FarMar::Market.new(market)
      end
      markets
    end

    def self.find(id)
      markets = self.all
      markets.find {|market| market.id == id}
    end

    def self.search(search_term)
      ms = self.all
      ms.find_all {|m| m.name.downcase.include?(search_term) || m.vendors.find {|v| v.name.downcase.include?(search_term)}}
    end

    def vendors
      vendors = Vendor.all
      vendors.find_all {|vendor| vendor.market_id == @id}
    end

    def products
      vs = vendors
      p =[]
      vs.each {|v| p += v.products}
      p
    end

    def preferred_vendor
      vs = vendors
      vs.max_by {|v| v.revenue}
    end

    def worst_vendor
      vs = vendors
      vs.min_by {|v| v.revenue}
    end
  end

end
