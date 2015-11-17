# Date helper methods
module DateHelper
  def self.add_if_weekend(date)
    date += date.saturday? ? 3 : 0
    date.sunday? ? date + 2 : date
  end
end
