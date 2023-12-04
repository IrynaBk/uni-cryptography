require 'rails_helper'


RSpec.describe RsaController, type: :controller do
  let(:private_key) { OpenSSL::PKey::RSA.generate(2048).to_pem }
  let(:public_key) { OpenSSL::PKey::RSA.generate(2048).public_key.to_pem }


  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with('PUBLIC_KEY').and_return(public_key)
    allow(ENV).to receive(:[]).with('PRIVATE_KEY').and_return(private_key)
  end

  describe 'POST #benchmark' do
    it 'returns benchmark results' do
      post :benchmark, params: { iterations: 10 }
      expect(response).to be_successful
      expect(assigns(:rsa_time)).to be_present
      expect(assigns(:rc5_time)).to be_present
    end
  end

  describe 'POST #encrypt' do
    it 'encrypts the uploaded file' do
      allow_any_instance_of(OpenSSL::PKey::RSA).to receive(:public_encrypt).and_return('encrypted_content')
      allow(Base64).to receive(:strict_encode64).and_return('encoded_data')

      file = fixture_file_upload('test_file.txt', 'text/plain')
      post :encrypt, params: { file: file }

      expect(response).to be_successful
      expect(assigns(:encoded_data)).to eq('encoded_data')
    end
  end

  describe 'POST #decrypt' do
    it 'decrypts the uploaded file and send it as attachment' do
      allow_any_instance_of(OpenSSL::PKey::RSA).to receive(:private_decrypt).and_return('decrypted_content')
      allow(Base64).to receive(:strict_decode64).and_return('decoded_data')
      allow_any_instance_of(RsaController).to receive(:determine_file_type).and_return({ content_type: 'text/plain', extension: 'txt' })

      file_content = 'encrypted_content'
      encrypted_file = Tempfile.new('encrypted_file')
      encrypted_file.write(file_content)
      encrypted_file.rewind

      file = fixture_file_upload(encrypted_file.path, 'application/octet-stream')
      post :decrypt, params: { file: file }

      expect(response).to be_successful
      expect(response.headers['Content-Type']).to eq('text/plain')
      expect(response.headers['Content-Disposition']).to match(/^attachment/)
    end
  end
end