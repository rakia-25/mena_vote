module YearHelper
  def year_columns
    {
      'name': 'Année'
    }
  end

  def year_forms
    {
      'name': {
        'title': 'Année',
        'field': 'text'
      }
    }
  end

  def year_actions
    {
      'edit': 'Modifier'
    }
  end

  def year_filters
    {
      'query': {
        'title': 'Recherche',
        'field': 'number'
      }
    }
  end
end
