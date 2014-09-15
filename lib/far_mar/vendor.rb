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
        vendors << FarMar::Sale.new(vendor)
      end
      vendors
    end


  end
end
