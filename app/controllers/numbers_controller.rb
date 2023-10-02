class NumbersController < ApplicationController
  before_action :check_params

  def generate
    config = Rails.configuration.python_modules.lc_generator
    x = params[:x] || 0
    n = params[:n] || 0
    result = `python lib/assets/python/generate_numbers.py #{config[:a]} #{config[:m]} #{config[:c]} #{x} #{n}`
    data = JSON.parse(result)
    @numbers = data["result"]
    @period = data["period"]
    session[:numbers] = @numbers
  end

  def download
    @numbers = session[:numbers]
    if @numbers.empty?
      flash[:alert] = "Error: No numbers to download."
      # redirect_to root_path
    else
      content = @numbers.join("\n")
      send_data content, filename: "numbers.txt", type: "text/plain", disposition: "attachment"
    end
  end

  private

  def check_params
    x = params[:x].to_i
    n = params[:n].to_i
    
    if x < 0 || n < 0
      flash[:error] = "Values cannot be negative."
      redirect_to root_path
    end
  end
end
