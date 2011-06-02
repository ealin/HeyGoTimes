class TagController < ApplicationController

  def get_all_tags
    tags = Tag.all


    respond_to do |format|
      format.json { render :json => tags.to_json }
    end

  end
end
