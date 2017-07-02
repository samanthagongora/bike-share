RSpec.describe "User visits '/stations/1/edit'"do
  it "and sees the edit page" do
    Station.new(name: "Bret", dock_count: 2, city: "SF", installation_date: 010101)
    visit "/stations/1/edit"
    expect(page).to have_content("Edit")
  end
end
