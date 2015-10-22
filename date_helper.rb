# Date helper methods
class DateHelper
  def self.add_if_weekend(date)
    date += date.saturday? ? 3 : 0
    date.sunday? ? date + 2 : date
  end
end
