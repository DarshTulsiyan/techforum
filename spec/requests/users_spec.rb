require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "PATCH /users/:id" do
    it "updates the user with valid information" do
      user = User.create!(
        username: "darsh",
        email: "darsh@example.com"
      )

      patch user_path(user), params: {
        user: {
          username: "darsh_updated",
          email: "updated@example.com"
        }
      }

      user.reload

      expect(user.username).to eq("darsh_updated")
      expect(user.email).to eq("updated@example.com")
      expect(response).to redirect_to(user_path(user))
    end

    it "does not update the user with invalid information" do
      user = User.create!(
        username: "darsh",
        email: "darsh@example.com"
      )

      patch user_path(user), params: {
        user: {
          username: "",
          email: ""
        }
      }

      user.reload

      expect(user.username).to eq("darsh")
      expect(user.email).to eq("darsh@example.com")
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

describe "DELETE /users/:id" do
    it "deletes the user" do
      user = User.create!(
        username: "darsh",
        email: "darsh@example.com"
      )

      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)

      expect(response).to redirect_to(users_path)
    end
  end
end 

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


