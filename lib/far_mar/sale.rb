module FarMar
  class Sale
    attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id #amount is in cents

    def initialize(sales_array)
      @id = sales_array[0].to_i
      @amount = sales_array[1].to_i
      @purchase_time = sales_array[2]
      @vendor_id = sales_array[3].to_i
      @product_id = sales_array[4].to_i
    end

    def self.all
      sales = []
      CSV.read("support/sales.csv").each do |sale|
        sales << FarMar::Sale.new(sale)
      end
      sales
    end

    def self.find(id)
      sales = self.all
      sales.find {|sale| sale.id == id}
    end
    

  end
end
