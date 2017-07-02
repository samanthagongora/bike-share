RSpec.describe "User creates station" do
  it "with valid attributes" do
    visit '/stations/new'
    fill_in("station[name]", with: "Buster")
    fill_in("station[dock_count]", with: 5)
    fill_in("station[city]", with: "SF")
    fill_in("station[installation_date]", with: 010101)
    click_button("Create Station")

    station = Station.last
    expect(current_path).to eq("/station/#{jockey.id}")
    expect(page).to have_content("Buster")
  end
end