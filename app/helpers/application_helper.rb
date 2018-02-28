module ApplicationHelper

  def format_date_time(date_time)
    date_time.in_time_zone.strftime("%a, %-m/%d/%Y at %l:%M")
  end

end
