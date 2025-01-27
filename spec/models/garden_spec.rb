require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  it 'finds a uniq list of plants with harvest time less than 100' do

    @turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)


    @plot_1 = @turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
    @plot_2 = @turing_garden.plots.create!(number: 26, size: "Small", direction: "West")


    @plant_1 = Plant.create!(name: 'corn', description: 'Yellow and sweet', days_to_harvest: 45)
    @plant_2 = Plant.create!(name: 'carrot', description: 'Orange and crisp', days_to_harvest: 606)
    @plant_3 = Plant.create!(name: 'pumpkin', description: 'Orange and spooky', days_to_harvest: 502)
    @plant_4 = Plant.create!(name: 'potato', description: 'Brown and savory', days_to_harvest: 35)

    @plot_plants_1 = PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_1.id)
    @plot_plants_2 = PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_2.id)
    @plot_plants_3 = PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_3.id)
    @plot_plants_4 = PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_2.id)
    @plot_plants_5 = PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_3.id)
    @plot_plants_6 = PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_4.id)

    expect(@turing_garden.uniqplants).to eq(["corn", "potato"])
  end
end
