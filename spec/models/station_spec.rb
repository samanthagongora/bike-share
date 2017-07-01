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
end
