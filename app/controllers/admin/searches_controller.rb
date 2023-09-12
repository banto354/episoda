# frozen_string_literal: true

class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @query = params[:query]
    @users = User.where("name LIKE ?", "%#{@query}%").order("created_at DESC")
    @episodes = Episode.where("title LIKE ?", "%#{@query}%").order("created_at DESC")
  end
end
