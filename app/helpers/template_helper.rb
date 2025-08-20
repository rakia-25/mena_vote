module TemplateHelper
  def profile
    User.profiles.map{ |s| [t("enum.profile.#{s[0]}"), s[0]] }
  end

  def status
    Inscription.statuses.map{ |s| [t("enum.status.#{s[0]}"), s[0]] }
  end

  def studying_level
    Inscription.studying_levels.map{ |s| [t("enum.studying_level.#{s[0]}"), s[0]] }
  end

  def age
    Inscription.ages.map{ |s| [t("enum.age.#{s[0]}"), s[0]] }
  end

  def region_filtarable
    Region.all.select('id, name as title').order('created_at asc')
  end
end
