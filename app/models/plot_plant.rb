class PlotPlant < ApplicationRecord
  has_many :plots
  has_many :plants
end
