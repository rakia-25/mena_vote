module MetaTagsHelper
  def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) : "TARMAMUN MU | Reconnaître le Mérite dans la Culture Nigérienne"
  end

  def meta_name
    content_for?(:meta_name) ? content_for(:meta_name) : "Honorer l'Excellence Culturelle au Niger"
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : "Une Cérémonie d'Hommage à l'Excellence et de Reconnaissance du Mérite dans la Culture Nigerienne"
  end

  def meta_image
    content_for?(:meta_image) ? "#{content_for(:meta_image)}" : "https://tarmamunmu-627fdb630b83.herokuapp.com/logo-rounded.jpg"
  end
end