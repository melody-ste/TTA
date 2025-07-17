class SpecializationsController < ApplicationController
# <!-- new update carousel-->
  def show
    @specialization = Specialization.find(params[:id])
    @medias = @specialization.multimedias
  end
end
