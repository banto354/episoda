# frozen_string_literal: true

class Public::HomesController < ApplicationController
  def top
    if user_signed_in?
      redirect_to episodes_path
    elsif admin_signed_in?
      redirect_to admin_episodes_path
    end
  end

  def about
  end
end
