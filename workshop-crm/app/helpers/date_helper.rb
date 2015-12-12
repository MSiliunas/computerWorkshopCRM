# Date helper methods
module DateHelper
  def self.add_if_weekend(date)
    date += date.saturday? ? 3.days : 0.days
    date.sunday? ? date + 2.days : date
  end
end
