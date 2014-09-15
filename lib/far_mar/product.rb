module FarMar
  class Product
    attr_accessor :id, :name, :vendor_id

    def initialize(product_array)
      @id = product_array[0].to_i
      @name = product_array[1]
      @vendor_id = product_array[2].to_i
    end

    def self.all
      products = []
      CSV.read("support/products.csv").each do |product|
        products << FarMar::Product.new(product)
      end
      products
    end

    def self.find(id)
      products = self.all
      products.find {|product| product.id == id}
    end
  end
end
