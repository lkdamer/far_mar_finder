module FarMar
  class FarMarStuff
    def self.all
      if @thingy == nil
        file_name = "./support/#{self.name.to_s.downcase.split("::")[1] + 's'}.csv"
        @thingy = CSV.read(file_name).collect do |thing|
          self.new(thing)
        end
      end
      @thingy
    end

    def self.find(id)
      thingies = self.all
      thingies.find { |thingy| thingy.id == id}
    end
  end

  class Sale < FarMar::FarMarStuff
    attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id #amount is in cents

    def initialize(sales_array)
      @id = sales_array[0].to_i
      @amount = sales_array[1].to_i
      @purchase_time = DateTime.parse(sales_array[2])
      @vendor_id = sales_array[3].to_i
      @product_id = sales_array[4].to_i
    end

    # def self.all
      # if @sales == nil
        # @sales = []
        # CSV.read("support/sales.csv").each do |sale|
          # @sales << FarMar::Sale.new(sale)
        # end
      # end
      # @sales
    #end

    # def self.find(id)
    #   sales = self.all
    #   sales.find {|sale| sale.id == id}
    # end

    def vendor
      vendors = Vendor.all
      vendors.find {|vendor| vendor.id == @vendor_id}
    end

    def product
      products = Product.all
      products.find {|product| product.id == @product_id}
    end

    def self.between(beginning_time, end_time)
      boogers = self.all
      boogers.find_all {|booger| booger.purchase_time.between?(beginning_time, end_time)}
    end

  end
end
