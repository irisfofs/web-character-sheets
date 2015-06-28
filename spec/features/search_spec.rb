require 'spec_helper.rb'

feature "Looking up characters", js: true do
  before do
    Sheet.create!(name: 'Baked Potato w/ Cheese')
    Sheet.create!(name: 'Garlic Mashed Potatoes')
    Sheet.create!(name: 'Potatoes Au Gratin')
    Sheet.create!(name: 'Baked Brussel Sprouts')
  end
  scenario "finding characters" do
    visit '/'
    fill_in "keywords", with: "baked"
    click_on "Search"

    expect(page).to have_content("Baked Potato")
    expect(page).to have_content("Baked Brussel Sprouts")
  end
end
