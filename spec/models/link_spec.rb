require 'rails_helper'

RSpec.describe "a user", type: :model do
  context "that has just been created" do
    let!(:user) { User.create(username: "Jai", password: "123") }
    let!(:link) { Link.create(url: "http://link.com",
                              title: "kfskdshlgsdh",
                              user_id: user.id,
                              list_id: 0) }

    it "has a default status of false" do
      expect(link.status).to eq(false)
    end
  end
end