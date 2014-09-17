require 'spec_helper'

describe FarMar::Product do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Product).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Product.all.count).to eq 8193
    end

    it "responds to 'find'" do
      expect(FarMar::Product).to respond_to :find
    end

    it "responds to 'by_vendor'" do
      expect(FarMar::Product).to respond_to :by_vendor
    end

    it "find the first product by market 1" do
      expect(FarMar::Product.by_vendor(1).first.name).to eq "Dry Beets"
    end

    it "returns top products in order of total revenue" do
      expect(FarMar::Product.most_revenue(5)[0].name).to eq "Defeated Fruit"
    end

    it "finds the product by name [and returns the instance!]" do
      expect(FarMar::Product.find_by_name("Outrageous Burrito").name).to eq "Outrageous Burrito"
    end

    it "finds all products with search term in the name" do
      expect(FarMar::Product.find_by_name_term("apple")[0].name).to eq "Green Apples"
    end
  end

  describe "attributes" do
    let(:product) { FarMar::Product.find(10) }
    # 10,Kertzmann LLC,11,3

    it "has the id 10" do
      expect(product.id).to eq 10
    end

    it "has the name" do
      expect(product.name).to eq "Black Apples"
    end

    it "has the vendor id 5" do
      expect(product.vendor_id).to eq 5
    end
  end

  describe "associations" do
    let(:product) { FarMar::Product.find(62) }

    it "responds to :market" do
      expect(product).to respond_to :vendor
    end

    it "market_id matches the markets id" do
      expect(product.vendor.id).to eq product.vendor_id
    end

    it "responds to :sales" do
      expect(product).to respond_to :sales
    end

    it "has 1 sales" do
      expect(product.sales.count).to eq 2
    end

    it "returns number of sales" do
      expect(product.number_of_sales).to eq 2
    end

  end

end
