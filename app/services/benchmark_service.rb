require 'base64'

class BenchmarkService
    def self.run_benchmark(iterations = 100)
      result = BenchmarkService.new(iterations).run
      { rsa_time: result[:rsa_time], rc5_time: result[:rc5_time] }
    end
  
    def initialize(iterations)
      @iterations = iterations
    end
  
    def run
      @rsa_time = Benchmark.realtime { run_rsa_encryption }
      @rc5_time = Benchmark.realtime { run_rc5_encryption }
  
      { rsa_time: @rsa_time, rc5_time: @rc5_time }
    end
  
    private
  
    def run_rsa_encryption
      public_key = OpenSSL::PKey::RSA.new(ENV['PUBLIC_KEY'])
      data = 'sample_data'
  
      @iterations.times do
        enc = public_key.public_encrypt(data)
        Base64.strict_encode64(enc)
      end
    end
  
    def run_rc5_encryption
      @iterations.times do
        rc5
      end
    end
  
    def rc5
      @temp_file_path ||= begin
        temp_file = Tempfile.new('temp_hash_file')
        passcode = 'passcode'
        File.open(temp_file.path, 'wb') { |f| f.write('sample_data') }
        python_command = ENV['PYTHON_COMMAND']
        encrypted = `#{python_command} lib/assets/python/get_encrypted_file.py #{temp_file.path} #{passcode}`
        encrypted
      end
    end
  end

  