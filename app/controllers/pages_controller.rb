class PagesController < ApplicationController

  def about
  end

  def spa
    respond_to |format|
    format.json
  end

end
