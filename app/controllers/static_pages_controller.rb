class StaticPagesController < ApplicationController
  layout 'inscription'

  def privacy_policy
    render '/static_pages/privacy_policy'
  end

  def terms
    render '/static_pages/terms'
  end
end
  