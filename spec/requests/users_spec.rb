require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    it "creates a new user" do
      expect {
        post users_path, params: {
          user: {
            username: "darsh",
            email: "darsh@example.com"
          }
        }
      }.to change(User, :count).by(1)

      user = User.last

      expect(user.username).to eq("darsh")
      expect(user.email).to eq("darsh@example.com")

      expect(response).to redirect_to(users_path)
    end
  end
end

