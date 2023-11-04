class NumbersController < ApplicationController
  include Downloadable
  before_action :check_params

  def generate
    x = params[:x].to_i || 0
    n = params[:n].to_i || 0
    result = `python lib/assets/python/generate_numbers.py #{x} #{n}`
    data = JSON.parse(result)
    @numbers = data["result"]
    @period = data["period"]
  end

  def download
    @numbers = params[:numbers]
    filename = params[:filename]
    download_data(@numbers, filename)
  end

  private

  def check_params
    if params[:x] && params[:n]
      errors = []
      
      if  !(params[:x] =~ /\A\d+\z/ && params[:n] =~ /\A\d+\z/)
        errors << "Parameters should be non-negative number."
        params[:x] = 0
        params[:n] = 0
      end
    
      unless errors.empty?
        flash[:error] = errors.join(' ')
      end
    end
  end
end
