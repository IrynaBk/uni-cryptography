class DigitalSignatureController < ApplicationController
    include Downloadable
      def index
      end
    
      def generate_signature
        input_data = params[:input_data]
        file = params[:file]
    
        if input_data.present?
          @signature = generate_signature_for_string(input_data)
        elsif file.present?
          @signature = generate_signature_for_file(file.tempfile)
        else
          flash[:error] = 'Please provide input data or choose a file.'
          redirect_to root_path
          return
        end
        render :index
      end
    
      def verify_signature
        file = params[:file]
        signature_file = params[:signature_file].tempfile
    
        if file.present? && signature_file.present?
          result = verify_signature_for_file(file.tempfile, signature_file)
          @verification_result = result ? 'Signature is valid.' : 'Signature is invalid.'
          render :index
        else
          flash[:error] = 'Please provide both file and signature file.'
          redirect_to root_path
        end
      end

      def download
        signature = params[:signature]
        download_data(signature, 'signature')
      end
    
      private
    
      def generate_signature_for_string(data)
        private_key = OpenSSL::PKey::DSA.new(ENV['PRIVATE_DSA_KEY'])
        digest = OpenSSL::Digest::SHA1.digest(data)
        signature = private_key.syssign(digest)
        signature.unpack1('H*')
      end
    
      def generate_signature_for_file(file)
        private_key = OpenSSL::PKey::DSA.new(ENV['PRIVATE_DSA_KEY'])
        data = File.read(file)
        digest = OpenSSL::Digest::SHA1.digest(data)
        signature = private_key.syssign(digest)
        signature.unpack1('H*')
      end
    
      def verify_signature_for_file(file, signature_file)
        public_key = OpenSSL::PKey::DSA.new(ENV['PUBLIC_DSA_KEY'])
        data = File.read(file)
        signature = File.read(signature_file).scan(/../).map { |x| x.hex }.pack('c*')
        digest = OpenSSL::Digest::SHA1.digest(data)
        public_key.sysverify(digest, signature)
      end
    
      # def render_result(result)
      #   @result = result ? 'Signature is valid.' : 'Signature is invalid.'
      #   # render :result
      # end
end
