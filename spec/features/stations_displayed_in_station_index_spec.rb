RSpec.describe "User sees all stations" do
  it "when visiting '/stations'" do
    #set up necessary data
    names = ["sam", "bret", "marc", "matt"]
    names.each do |name|
      Station.create(name: name, dock_count: 5, city: "Denver", installation_date: 101010)
    end
    visit '/stations'

    names.each do |name|
    expect(page).to have_content(name)
    end
  end
end
