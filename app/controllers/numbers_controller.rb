class NumbersController < ApplicationController
  before_action :check_params

  def generate
    config = Rails.configuration.python_modules.lc_generator
    x = params[:x].to_i || 0
    n = params[:n].to_i || 0
    result = `python lib/assets/python/generate_numbers.py #{config[:a]} #{config[:m]} #{config[:c]} #{x} #{n}`
    data = JSON.parse(result)
    @numbers = data["result"]
    @period = data["period"]
    session[:numbers] = @numbers
  end

  def download
    @numbers = session[:numbers]
    if @numbers.empty?
      flash[:error] = "Error: No numbers to download."
      redirect_to root_path
    else
      content = @numbers.join("\n")
      send_data content, filename: "numbers.txt", type: "text/plain", disposition: "attachment"
    end
  end

  private

  def check_params
    if params[:x] && params[:n]
      errors = []
      
      if  !(params[:x] =~ /\A\d+\z/ && params[:n] =~ /\A\d+\z/)
        errors << "Parameters should be non-negative integers."
        params[:x] = 0
        params[:n] = 0
      end
    
      unless errors.empty?
        flash[:error] = errors.join(' ')
      end
    end
  end
end
