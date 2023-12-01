require 'rails_helper'

RSpec.describe "Rsas", type: :request do
  describe "GET /encrypt" do
    it "returns http success" do
      get "/rsa/encrypt"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /decrypt" do
    it "returns http success" do
      get "/rsa/decrypt"
      expect(response).to have_http_status(:success)
    end
  end

end
