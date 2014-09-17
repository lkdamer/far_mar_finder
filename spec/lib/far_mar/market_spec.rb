require 'spec_helper'
describe FarMar::Market do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Market).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Market.all.count).to eq 500
    end

    it "responds to 'find'" do
      expect(FarMar::Market).to respond_to :find
    end

    it "finds markets with a name, or a vendor name including search term" do
      expect(FarMar::Market.find_by_name("school").count).to eq 3
    end

  end

  describe "attributes" do
    let(:market) { FarMar::Market.find(1) }
    # 1,People's Co-op Farmers FarMar::Market,30,Portland,Multnomah,Oregon,97202

    it "has the id 1" do
      expect(market.id).to eq 1
    end

    it "has the name 'People's Co-op Farmers FarMar::Market'" do
      expect(market.name).to eq "People's Co-op Farmers Market"
    end

    it "has the address '30th and Burnside'" do
      expect(market.address).to eq "30th and Burnside"
    end

    it "has the city 'Portland'" do
      expect(market.city).to eq "Portland"
    end
    it "has the county 'Multnomah'" do
      expect(market.county).to eq "Multnomah"
    end
    it "has the state 'Oregon'" do
      expect(market.state).to eq "Oregon"
    end
    it "has the zip '97202'" do
      expect(market.zip).to eq "97202"
    end

  end

  describe "instance methods" do
    let(:market) { FarMar::Market.find(1) }
    it "responds to vendors" do
      expect(FarMar::Market.new({})).to respond_to :vendors
    end

    it "finds the vendors" do
      expect(market.vendors.first.id).to eq 1
    end

    it "returns a collection of product instances sold at the market" do
      expect(market.products.first.name).to eq "Dry Beets"
    end

    it "returns the preferred vendor for a market" do
      expect(market.preferred_vendor.name).to eq "Reynolds, Schmitt and Klocko"
    end

    it "returns the worst vendor for a market" do
      expect(market.worst_vendor.name).to eq "Zulauf and Sons"
    end

    it "returns the preferred vendor for a market on given day" do
      expect(market.preferred_vendor_by_date(DateTime.new(2013, 11, 11)).name).to eq "Kris and Sons"
    end

    it "returns the worst vendor for a market on a given day" do
      expect(market.worst_vendor_by_date(DateTime.new(2013, 11, 11)).name).to eq "Hamill, Kilback and Pfeffer"
    end
  end
end
