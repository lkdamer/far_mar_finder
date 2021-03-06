module FarMar
  class FarMarStuff
    def self.all
      @thingy ||= make_the_thingies
    end

    def self.make_the_thingies
      file_name = "./support/#{self.name.to_s.downcase.split("::")[1] + 's'}.csv"
      CSV.read(file_name).collect do |thing|
        self.new(thing)
      end
    end

    def self.find(id)
      thingies = self.all
      thingies.find { |thingy| thingy.id == id}
    end
  end

  class Market < FarMar::FarMarStuff
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


    # def self.all
      # markets = []
      # CSV.read("./support/markets.csv").each do |market|
        # markets << self.new(market)
      # end
      # markets
    # end

    # def self.find(id)
      # markets = self.all
      # markets.find {|market| market.id == id}
    # end

    def self.find_by_name(search_term)
      ms = self.all
      ms.find_all {|m| m.name.downcase.include?(search_term) || m.vendors.find {|v| v.name.downcase.include?(search_term)}}
    end

    def self.find_by_state(st)
      ms = Market.all
      ms.find_all {|m| m.state.downcase == st.downcase}
    end

    def to_s
      return @name
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

    def preferred_vendor_by_date(date)
      vs = vendors
      vs.max_by {|v| v.revenue_by_date(date)}
    end

    def worst_vendor
      vs = vendors
      vs.min_by {|v| v.revenue}
    end

    def worst_vendor_by_date(date)
      vs = vendors
      vs.min_by {|v| v.revenue_by_date(date)}
    end
  end

end
