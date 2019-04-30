class ContactsController < ApplicationController

  def new
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
  end
  
  def create
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
    redirect_to root_path
  end
end