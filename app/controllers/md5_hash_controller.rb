require 'tempfile'

class Md5HashController < ApplicationController
  include Downloadable

  def new
  end

  def create
    if params[:content].present?
      content = params[:content]
      @hash = get_hash(content)
    elsif params[:file].present?
      file = params[:file]
      content = file.read
      @hash = get_hash(content)
    end
    render :new
  end

  def download
    @hash = params[:hash]
    filename = params[:filename]
    download_data(@hash, filename)
  end
end
