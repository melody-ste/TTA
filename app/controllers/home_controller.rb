class HomeController < ApplicationController

  def home 
    @specializations = Specialization.all
  end
end
