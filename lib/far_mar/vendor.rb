module FarMar
  class Vendor
    attr_accessor :id, :name, :no_of_employees, :market_id

    def initialize(vendor_array)
      @id = vendor_array[0].to_i
      @name = vendor_array[1]
      @no_of_employees = vendor_array[2].to_i
      @market_id = vendor_array[3].to_i
    end

    def self.all
      vendors = []
      CSV.read("support/vendors.csv").each do |vendor|
        vendors << FarMar::Vendor.new(vendor)
      end
      vendors
    end

    def self.find(id)
      vendors = self.all
      vendors.find {|vendor| vendor.id == id}
    end

    def self.find_by_name(n)
      vs = self.all
      vs.find {|v| v.name.downcase == n.downcase}
    end

    def self.find_by_name_search(search_term)
      vs = self.all
      vs.find_all {|v| v.name.downcase.include? search_term.downcase}
    end

    def self.by_market(market_id)
      self.all.find_all {|vendor| vendor.market_id == market_id}
    end

    def self.most_revenue(n)
      vs = self.all
      vs.sort_by {|v| v.revenue}.first(n)
    end

    def self.most_items(n)
      vs = self.all
      vs.sort_by {|v| v.sales.count}.first(n)
    end

    def self.revenue_date(date)
      vs = self.all
      r = 0
      vs.each {|v| r += v.revenue_by_date(date)}
      r
    end

    def to_s
      @name
    end

    def market #usually Rachel puts @vendor
      markets = Market.all
      markets.find {|market| market.id == @market_id}
    end

    def products
      products = Product.all
      products.find_all {|product| product.vendor_id == @id}
    end

    def sales
      sales = Sale.all
      sales.find_all {|sale| sale.vendor_id == @id}
    end

    def revenue
      s = sales
      r = 0
      s.each {|sale| r += sale.amount}
      return r
    end

    def revenue_by_date(date)
      date1 = DateTime.new(date.year, date.month, date.day, 0, 0, 0, 0)
      date2 = DateTime.new(date.year, date.month, date.day + 1, 0, 0, 0, 0)
      ss = Sale.between(date1, date2)
      toot = ss.find_all {|sale| sale.vendor_id == @id}
      r = 0
      toot.each {|sale| r += sale.amount}
      return r
    end

  end
end
