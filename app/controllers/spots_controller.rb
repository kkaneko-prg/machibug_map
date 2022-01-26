class SpotsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @spots = Spot.all
  end
end
