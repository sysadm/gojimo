class ExamsController < ApplicationController
  def index
    @qualifications = Qualification.not_empty
  end

  def get_all
    ApiStore.get_all
    redirect_to root_path
  end

  def remove_all
    ApiStore.remove_all
    redirect_to root_path
  end
end
