require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    it "creates a user" do
      expect {
        post users_path, params: { user: { username: "darsh", email: "darsh@example.com" } }
      }.to change(User, :count).by(1)
      expect(response).to redirect_to(users_path)
    end

    it "renders new for invalid data" do
      post users_path, params: { user: { username: "", email: "" } }
      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "GET /users" do
    it "lists users" do
      User.create!(username: "darsh", email: "darsh@example.com")
      get users_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("darsh")
    end
  end

  describe "GET /users/:id" do
    it "shows a user" do
      user = User.create!(username: "darsh", email: "darsh@example.com")
      get user_path(user)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("darsh")
    end
  end

  describe "GET /users/new" do
    it "renders the new form" do
      get new_user_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /users/:id/edit" do
    it "renders the edit form" do
      user = User.create!(username: "darsh", email: "darsh@example.com")
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /users/:id" do
    it "updates a user with valid information" do
      user = User.create!(username: "darsh", email: "darsh@example.com")
      patch user_path(user), params: { user: { username: "updated", email: "updated@example.com" } }
      expect(response).to redirect_to(user_path(user))
      expect(user.reload.username).to eq("updated")
    end

    it "renders edit with invalid information" do
      user = User.create!(username: "darsh", email: "darsh@example.com")
      patch user_path(user), params: { user: { username: "", email: "" } }
      expect(response).to have_http_status(:unprocessable_content)
      expect(user.reload.username).to eq("darsh")
    end
  end

  describe "DELETE /users/:id" do
    it "deletes a user" do
      user = User.create!(username: "darsh", email: "darsh@example.com")
      expect { delete user_path(user) }.to change(User, :count).by(-1)
      expect(response).to redirect_to(users_path)
    end
  end
end
