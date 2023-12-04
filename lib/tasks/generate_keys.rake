namespace :keys do
    desc 'Generate RSA keys and set as environment variables'
    task :generate_and_set_env do
      begin
        private_key = OpenSSL::PKey::RSA.new(2048)
        public_key = private_key.public_key
  
        File.open('.env', 'a') do |file|
          file.puts("PRIVATE_KEY=\"#{private_key.to_pem}\"")
          file.puts("PUBLIC_KEY=\"#{public_key.to_pem}\"")
        end
      rescue StandardError => e
        puts "Error generating RSA keys: #{e.message}"
      end
  
      puts 'RSA keys generated and set as environment variables successfully!'
    end

    desc 'Generate DSA keys and set as environment variables'
    task :generate_dsa_and_set_env do
      begin
        private_key = OpenSSL::PKey::DSA.new(2048)
        public_key = private_key.public_key

        File.open('.env', 'a') do |file|
          file.puts("PRIVATE_DSA_KEY=\"#{private_key.to_pem}\"")
          file.puts("PUBLIC_DSA_KEY=\"#{public_key.to_pem}\"")
        end
      rescue StandardError => e
        puts "Error generating DSA keys: #{e.message}"
      end
  
      puts 'DSA keys generated and set as environment variables successfully!'
    end

  end
  