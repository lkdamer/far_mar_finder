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

    def self.by_vendor(vendor_id)
      self.all.find_all {|product| product.vendor_id == vendor_id}
    end

    def self.most_revenue(n)
      ps = self.all
      ps.sort_by {|p| p.revenue }.first(n)
    end

    def self.find_by_name(n)
      ps = self.all
      ps.find {|p| p.name.downcase == n.downcase}
    end

    def self.find_by_name_term(term)
      ps = self.all
      ps.find_all {|p| p.name.downcase.include?(term.downcase)}
    end

    def revenue
      ss = sales
      r = 0
      ss.each { |s| r += s.amount }
      return r
    end

    def vendor
      vendors = Vendor.all
      vendors.find {|vendor| vendor.id == @vendor_id}
    end

    def sales
      s = Sale.all
      s.find_all {|sale| sale.product_id == @id}
    end

    def number_of_sales
      sales.count
    end

  end
end
