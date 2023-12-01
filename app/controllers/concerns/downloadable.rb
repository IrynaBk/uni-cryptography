require 'base64'

module Downloadable
    extend ActiveSupport::Concern

    def get_hash(content)
        file = Tempfile.new('temp_hash_file')
        File.binwrite(file.path, content)  # binary content
        python_command = ENV['PYTHON_COMMAND']
        hash = `#{python_command} lib/assets/python/get_hash.py #{file.path}`
        file.unlink
        hash.strip
    end
      

    def create_file_hash(content, filename)
        File.write(filename, content)
        content = File.read(filename)
        hash = get_hash(content)
        hash.strip
    end

    def download_data(content, filename)
        if !content.present?
            flash[:error] = "Error: No data to download."
            redirect_to root_path
        end
        filename = filename.presence || 'result'
        filename += ".txt" unless filename.end_with?(".txt")
        stored_hash = get_hash(content)
        
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