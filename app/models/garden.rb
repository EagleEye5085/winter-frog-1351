class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plants
  has_many :plants, through: :plot_plants

  def uniqplants
    plots.joins(:plants).where("days_to_harvest < 100").pluck(:name).uniq
  end
end
