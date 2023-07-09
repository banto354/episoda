class Public::HomesController < ApplicationController
  def top
    if user_signed_in?
      redirect_to episodes_path
    end
  end
  
  def about
  end
end
