RSpec.describe Station do
  describe "Validations" do
    it "attributes exists" do
      station = Station.new(name: "bob", dock_count: 30, city: "San Franscisco", installation_date: 20160808)

      expect(station.name).to eq("bob")
      expect(station.dock_count).to eq(30)
      expect(station.city).to eq("San Franscisco")
      expect(station.installation_date).to eq(20160808)
    end
  end
  describe "Validations" do
  it "is invalid without a name" do
    station = Station.new(dock_count: 22, city: "Milan", installation_date: 20160808)

    expect(station).to_not be_valid
    end
  end
  describe "Validations" do
  it "is invalid without a dock count" do
    station = Station.new(name: "Bret", city: "Milan", installation_date: 20160808)

    expect(station).to_not be_valid
    end
  end
  describe "Validations" do
  it "is invalid without a city" do
    station = Station.new(name: "Bret", dock_count: 22, installation_date: 20160808)

    expect(station).to_not be_valid
    end
  it "is invalid without a date" do
    station = Station.new(name: "Bret", dock_count: 22, city: "Milan")

    expect(station).to_not be_valid
    end
  end
end
