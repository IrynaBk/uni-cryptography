require 'base64'

module Downloadable
    extend ActiveSupport::Concern

    def create_file_hash(content, filename)
        File.write(filename, content)
        content = File.read(filename)
        encoded_content = Base64.strict_encode64(content)
        hash = `python lib/assets/python/get_hash.py #{encoded_content}`

    end

    def download_data(content, filename)
        if content.empty?
            flash[:error] = "Error: No data to download."
            redirect_to root_path
        end
        filename = filename.presence || 'result'
        filename += ".txt" unless filename.end_with?(".txt")
        encoded_content = Base64.strict_encode64(content)
        stored_hash = `python lib/assets/python/get_hash.py #{encoded_content}`
        
        file_hash = create_file_hash(content, filename)
        if file_hash == stored_hash
            send_data File.read(filename), filename: filename, type: "text/plain", disposition: "attachment"
            File.delete(filename)

        else
            flash[:error] = "Error: File integrity issue detected."
            redirect_to root_path
        end
    end
end