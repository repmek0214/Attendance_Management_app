require 'rails_helper'

RSpec.describe "Admin::ShiftRequests", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/shift_requests/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/admin/shift_requests/update"
      expect(response).to have_http_status(:success)
    end
  end

end
