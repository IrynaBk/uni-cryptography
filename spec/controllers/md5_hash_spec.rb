require 'rails_helper'


def test_cases
    {
      '' => 'd41d8cd98f00b204e9800998ecf8427e',
      'a' => '0cc175b9c0f1b6a831c399e269772661',
      'abc' => '900150983cd24fb0d6963f7d28e17f72',
      'message digest' => 'f96b697d7cb7938d525a2f31aaf161d0',
      'abcdefghijklmnopqrstuvwxyz' => 'c3fcd3d76192e4007dfb496cca67e13b',
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' => 'd174ab98d277d9f5a5611c2c9f419d9f',
      '12345678901234567890123456789012345678901234567890123456789012345678901234567890' => '57edf4a22be3c955ac49da2e2107b67a'
    }
end

RSpec.describe Md5HashController, type: :controller do
  describe 'post #generate' do


    test_cases.each do |content, expected_hash|
      context "when content is #{content}" do
        before do
          encoded_content = Base64.strict_encode64(content)
          allow_any_instance_of(Md5HashController).to receive(:`).with("python lib/assets/python/get_hash.py #{encoded_content}").and_return(expected_hash)

          post :generate, params: { content: content }
        end

        it "returns the correct hash: #{expected_hash}" do
          expect(assigns(:hash)).to eq(expected_hash)
        end

        it 'renders the generate template' do
          expect(response).to render_template(:generate)
        end

        it 'returns a successful response' do
          expect(response).to have_http_status(:success)
        end
      end
    end

    # context 'with no content' do
    #   before { get :generate }

    #   it 'returns a successful response' do
    #     expect(response).to have_http_status(:success)
    #   end

    #   it 'renders the generate template' do
    #     expect(response).to render_template(:generate)
    #   end
    # end
  end
end
