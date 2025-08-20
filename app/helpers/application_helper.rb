module ApplicationHelper
  include Pagy::Frontend
  
  ALERT_CSS = {
    'alert' => 'is-info',
    'error' => 'is-danger',
    'success' => 'is-success',
    'notice' => 'is-info'
  }

  def alert_style(value)
    ALERT_CSS[value]
  end

  def get_year_id(year)
    Year.find_by(name: year)&.id
  end
end
