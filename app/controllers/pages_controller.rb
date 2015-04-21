class PagesController < ApplicationController
  def index
  end

  def test
    render text: File.open("lib/tasks/#{params[:name]}.rb", "r").read
  end
end
