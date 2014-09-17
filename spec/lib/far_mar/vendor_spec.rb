require 'spec_helper'

describe FarMar::Vendor do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Vendor).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Vendor.all.count).to eq 2690
    end

    it "responds to 'find'" do
      expect(FarMar::Vendor).to respond_to :find
    end

    it "responds to 'by_market'" do
      expect(FarMar::Vendor).to respond_to :by_market
    end

    it "find the first vendor by market 1" do
      expect(FarMar::Vendor.by_market(100).first.name).to eq "Schiller-Ledner"
    end

    it "finds the top n vendors in terms of revenue" do
      expect(FarMar::Vendor.most_revenue(1)[0].name).to eq "Homenick, Ryan and Corwin"
    end

    it "finds the top n vendors in terms of no. of items sold" do
      expect(FarMar::Vendor.most_items(1)[0].name).to eq "Muller, Rice and Cole"
    end

    it "finds the total revenue for a given date" do
      expect(FarMar::Vendor.revenue_date(DateTime.new(2013, 11, 11))).to eq 9156502
    end

    it "finds the vendor by name [and returns the instance!]" do
      expect(FarMar::Vendor.find_by_name("Ledner Group").name).to eq "Ledner Group"
    end
  end

  describe "attributes" do
    let(:vendor) { FarMar::Vendor.find(10) }
    # 10,Kertzmann LLC,11,3

    it "has the id 10" do
      expect(vendor.id).to eq 10
    end
    it "has the name" do
      expect(vendor.name).to eq "Kertzmann LLC"
    end
    it "has the no of employees 11" do
      expect(vendor.no_of_employees).to eq 11
    end
    it "has the market_id 3" do
      expect(vendor.market_id).to eq 3
    end
  end

  describe "instance methods" do
    it "calculates revenue for vendor" do
      expect(FarMar::Vendor.all[0].revenue).to eq 38259
    end
  end

  describe "associations" do
    let(:vendor) { FarMar::Vendor.find(1) }

    it "responds to :market" do
      expect(vendor).to respond_to :market
    end

    it "market_id matches the markets id" do
      expect(vendor.market.id).to eq vendor.market_id
    end

    it "responds to :sales" do
      expect(vendor).to respond_to :sales
    end

    it "has 7 sales" do
      expect(vendor.sales.count).to eq 7
    end

    it "responds to products" do
      expect(vendor).to respond_to :products
    end

    it "has 1 products" do
      expect(vendor.products.count).to eq 1
    end
  end

end
