class StaticPagesController < ApplicationController
  skip_before_filter :authenticate_user!

  layout 'application_non_menu'

  def home
  end
end
