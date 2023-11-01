module FileTypeDetector
    FILE_TYPE_DICTIONARY = {
        "\x89PNG\r\n\x1A\n".force_encoding('ASCII-8BIT') => { content_type: 'image/png', extension: 'png' },
        "\xFF\xD8".force_encoding('ASCII-8BIT') => { content_type: 'image/jpeg', extension: 'jpg' },
        "%PDF-".force_encoding('ASCII-8BIT') => { content_type: 'application/pdf', extension: 'pdf' },
      }

      def determine_file_type(binary_data)
        FILE_TYPE_DICTIONARY.each do |signature, info|
          if binary_data.start_with?(signature)
            return info
          end
        end
        { content_type: 'application/octet-stream', extension: 'bin' }
      end

end