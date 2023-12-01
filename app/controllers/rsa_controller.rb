require 'base64'

class RsaController < ApplicationController
  include FileTypeDetector

  before_action :load_keys

  def new
  end

  def benchmark
    iterations = params[:iterations].to_i || 100

    result = BenchmarkService.run_benchmark(iterations)

    @rsa_time = result[:rsa_time]
    @rc5_time = result[:rc5_time]
    render :new
  end

  def encrypt
    uploaded_file = params[:file]
    file_content = uploaded_file.read


    encrypted_message = ''
    i = 0
    block_size = @public_key.n.num_bytes - 11

    while true
      block = file_content[i * block_size, block_size]
      break if block.nil? || block.empty?

      i += 1
      encrypted_block = @public_key.public_encrypt(block, OpenSSL::PKey::RSA::PKCS1_PADDING)
      encrypted_message += encrypted_block
    end

    @encoded_data = Base64.strict_encode64(encrypted_message)

    send_data @encoded_data, filename: 'encrypted_file.txt', type: 'application/octet-stream', disposition: 'attachment'
  end
  
  def decrypt
    encrypted_data = params[:file].read

    decoded_data = Base64.strict_decode64(encrypted_data)
  
    decrypted_message = ''
    i = 0
    block_size = @private_key.n.num_bytes

    while true
      block = decoded_data[i * block_size, block_size]
      break if block.nil? || block.empty?

      i += 1
      decrypted_block = @private_key.private_decrypt(block, OpenSSL::PKey::RSA::PKCS1_PADDING)
      decrypted_message += decrypted_block
    end

    decrypted_data = decrypted_message

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
  def load_keys
    @public_key = OpenSSL::PKey::RSA.new(ENV['PUBLIC_KEY'])
    @private_key = OpenSSL::PKey::RSA.new(ENV['PRIVATE_KEY'])
  end
end
