require "rails_helper"

RSpec.describe Tag, type: :model do
  describe ".find_or_create_list" do
    it "creates normalized tags from a comma-separated list" do
      tags = Tag.find_or_create_list(" Ruby, Rails ,Database ")

      expect(tags.map(&:name)).to contain_exactly("Ruby", "Rails", "Database")
    end

    it "ignores blank tag names" do
      tags = Tag.find_or_create_list("Ruby, ,   ,Rails")
      expect(tags.map(&:name)).to contain_exactly("Ruby", "Rails")
    end

    it "returns an empty list for nil" do
      expect(Tag.find_or_create_list(nil)).to eq([])
    end

    it "reuses existing tags" do
      existing = Tag.create!(name: "Ruby")
      tags = Tag.find_or_create_list("Ruby")

      expect(tags).to eq([existing])
      expect(Tag.where(name: "Ruby").count).to eq(1)
    end
  end
end
