module ApplicationHelper
  def format_date_time(date_time)
    date_time.in_time_zone.strftime('%a, %-m/%d/%Y at %l:%M')
  end

  def get_weekday(date_time)
    date_time.in_time_zone.strftime('%A')
  end

  def get_date(date_time)
    date_time.in_time_zone.strftime('%-m/%d/%Y')
  end

  def get_time(date_time)
    date_time.in_time_zone.strftime('%l:%M %p')
  end
end
