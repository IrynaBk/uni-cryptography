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
      flash[:error] = "Error: No numbers to download."
      redirect_to root_path
    else
      content = @numbers.join("\n")
      send_data content, filename: "numbers.txt", type: "text/plain", disposition: "attachment"
    end
  end

  private

  def check_params
    errors = []
  
    x = params[:x].to_i
    n = params[:n].to_i

    errors << "Value for x should be an integer." unless params[:x].to_s == x.to_s
    errors << "Value for n should be an integer." unless params[:n].to_s == n.to_s
    
    errors << "Value for x cannot be negative." if x < 0
    errors << "Value for n cannot be negative." if n < 0
    
    unless errors.empty?
      flash[:error] = errors.join(' ')
      redirect_to root_path
    end
    
  end
end
