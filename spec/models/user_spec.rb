require "rails_helper"

RSpec.describe User, type: :model do
  it "creates a user with valid information" do
    user = User.new(
      username: "darsh",
      email: "darsh@example.com"
    )

    expect(user).to be_valid
  end

  it "does not allow an empty username" do
    user = User.new(
      username: "",
      email: "darsh@example.com"
    )

    expect(user).not_to be_valid
  end

  it "does not allow an empty email" do
    user = User.new(
      username: "darsh",
      email: ""
    )

    expect(user).not_to be_valid
  end

  it "does not allow duplicate usernames" do
    User.create!(
      username: "darsh",
      email: "darsh1@example.com"
    )

    duplicate_user = User.new(
      username: "darsh",
      email: "darsh2@example.com"
    )

    expect(duplicate_user).not_to be_valid
    expect(duplicate_user.errors[:username]).to include("has already been taken")
  end
end