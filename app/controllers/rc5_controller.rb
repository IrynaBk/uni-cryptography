

class Rc5Controller < ApplicationController
  include Downloadable
  include FileTypeDetector

  before_action :load_file, only: [:encrypt, :decrypt]
  # before_action :check_passcode, only: [:decrypt]

  def encrypt
    passcode = params[:passcode]
    # session[:passcode] = passcode
    python_command = ENV['PYTHON_COMMAND']
    encrypted = `#{python_command} lib/assets/python/get_encrypted_file.py #{temp_file_path} #{passcode}`
    send_data encrypted, filename: 'encrypted_file.txt', type: 'application/octet-stream', disposition: 'attachment'
  end

  def new
  end

  def decrypt
    @passcode = params[:passcode]
    python_command = ENV['PYTHON_COMMAND']
    decrypted_data = Base64.decode64(`#{python_command} lib/assets/python/get_decrypted_file.py #{temp_file_path} #{@passcode}`)
    type_info = determine_file_type(decrypted_data)
    content_type = type_info[:content_type]
    ext = type_info[:extension]
    file_path = "decrypted_file.#{ext}"

    File.open(file_path, 'wb') do |file|
      file.write(decrypted_data)
    end
    send_file(file_path, filename: file_path, type: content_type, disposition: 'attachment')
  end


  private

  def load_file
    @file_content = params[:file].read
  end

  def temp_file_path
    @temp_file_path ||= begin
      temp_file = Tempfile.new('temp_hash_file')
      File.open(temp_file.path, 'wb') { |f| f.write(@file_content) }
      temp_file.path
    end
  end

  def check_passcode
    @passcode = params[:passcode]
    unless session[:passcode] == @passcode
      flash[:alert] = 'Invalid passcode'
      render :new
    end
  end

end
