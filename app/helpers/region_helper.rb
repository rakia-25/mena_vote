module RegionHelper
  def region_columns
    {
      'name': 'Nom & Prénom'
    }
  end

  def region_forms
    {
      'name': {
        'title': 'Nom',
        'field': 'text'
      }
    }
  end

  def region_actions
    {
      'edit': 'Modifier'
    }
  end

  def region_filters
    {
      'created_from': {
        'title': 'Fait entre le',
        'field': 'date'
      },
      'created_to': {
        'title': 'Et le',
        'field': 'date'
      }
    }
  end
end
