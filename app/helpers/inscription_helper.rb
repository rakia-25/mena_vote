module InscriptionHelper
  def inscription_columns
    {
      'name': 'Nom & Prénom',
      'phone_whatsapps': 'Numéro whatsapps',
      'weigth': 'Poids',
      'displayed_height': 'Taille',
      'profession': 'Profession',
      'displayed_studying_level': 'Niveau d\'etude',
      'displayed_age': 'Age',
      'email': 'Addresse mail',
      'address': 'Addresse physique',
      'displayed_status': 'Statut',
      'region_name': 'Région'
    }
  end

  def inscription_forms
    {
      'photo': {
        'title': 'Photo',
        'field': 'image'
      },
      'last_name': {
        'title': 'Nom',
        'field': 'text'
      },
      'first_name': {
        'title': 'Prénom',
        'field': 'text'
      },
      'phone_whatsapps': {
        'title': 'Numéro whatsapps',
        'field': 'text'
      },
      'weigth': {
        'title': 'Poids',
        'field': 'text'
      },
      'height': {
        'title': 'Taille',
        'field': 'height'
      },
      'profession': {
        'title': 'Profession',
        'field': 'text'
      },
      'studying_level': {
        'title': 'Niveau d\'étude',
        'field': 'enum',
        'enum': 'studying_level'
      },
      'age': {
        'title': 'Age',
        'field': 'enum',
        'enum': 'age'
      },
      'email': {
        'title': 'Address email',
        'field': 'text'
      },
      'address': {
        'title': 'Addresse physique',
        'field': 'textarea'
      },
      'status': {
        'title': 'Status',
        'field': 'enum',
        'enum': 'status'
      },
      'region_id': {
        'title': 'Région',
        'field': 'model',
        'model_name': 'region'
      }
    }
  end

  def inscription_actions
    {
      'edit': 'Modifier',
      'show': 'Voir',
      'delete': 'Supprimer'
    }
  end

  def inscription_filters
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
