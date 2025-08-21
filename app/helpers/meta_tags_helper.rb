module MetaTagsHelper
  def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) : "MENA D'OR | Célébrer l’Excellence dans le Football Nigérien"
  end

  def meta_name
    content_for?(:meta_name) ? content_for(:meta_name) : "Honorer l’Excellence du Football au Niger"
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : "Une cérémonie qui rend hommage au talent et célèbre l’excellence dans le football nigérien."
  end

  def meta_image
    content_for?(:meta_image) ? "#{content_for(:meta_image)}" : "https://menavote-627fdb630b83.herokuapp.com/logo-rounded.jpg"
  end
end