require 'rails_helper'

describe User do
  describe "general" do
    let(:user){ build(:user) }
    it "is valid with default attributes" do
      expect(user).to be_valid
    end
    it "default user can be saved" do
      user = create(:user)
      expect(user.persisted?).to be_truthy
    end
    it "default unsaved user is not present int the DB" do
      expect(user.persisted?).to be_falsey
    end
    it "check presence of name" do
      should validate_presence_of(:name)
    end
    it "check presence of email" do
      should validate_presence_of(:email)
    end
    it "has_secured_pw" do
      should have_secure_password
    end
    it "create a user in db and verify name" do
      user = create(:user, name: "Foo Bar")
      expect(user.name).to eq("Foo Bar")
    end
    it "create a user in db and verify email" do
      user = create(:user, :name => "foobar", :password => "foobar")
      expect(user.email).to eq("foobar@email.com")
    end
  end

  describe "#name" do
    it "build a user with custom name" do
      user = build(:user, :name => "foo2")
      expect(user.name).to eq("foo2")
    end
  end

  describe "#email" do
    it "build a user with custom email" do
      user = build(:user, :email => "foo@foobar.com")
      expect(user.email).to eq("foo@foobar.com")
    end
  end

  describe "#password" do
    it "small password raises error" do
      user = build(:user, :password => "12345")
      expect(user).not_to be_valid
    end
  end

  describe "user validations" do
    it "without name is invalid" do
      user = build(:user, :name => nil)
      expect(user).not_to be_valid
    end
    it "without email is invalid" do
      user = build(:user, :email => nil)
      expect(user).not_to be_valid
    end
    it "with name length 2 is invalid" do
      user = build(:user, :name => "ab")
      expect(user).not_to be_valid
    end
    it "with name length 21 is invalid" do
      user = build(:user, :name => "austinseferian jenkins")
      expect(user).not_to be_valid
    end
    it "with name length 3 is valid" do
      user = build(:user, :name => "abc")
      expect(user).to be_valid
    end
    it "with name length 20 is valid" do
      user = build(:user, :name => "Aaron Rodgers GreenB")
      expect(user).to be_valid
    end
    it "with duplicate email is invalid" do
      user = create(:user)
      user2 = build(:user, :name => "Aaron Rogers", :email => user.email)
      expect(user2).to be_invalid
    end

    it "with password length 5 is invalid" do
      user = build(:user, :password => "12345")
      expect(user).not_to be_valid
    end
    it "with password length 6 is valid" do
      user = build(:user, :password => "123456")
      expect(user).to be_valid
    end
    it "with password length 17 is invalid" do
      user = build(:user, :password => "01234567890123456")
      expect(user).not_to be_valid
    end
    it "with password length 16 is valid" do
      user = build(:user, :password => "0123456789012345")
      expect(user).to be_valid
    end
    it "with nil password is invalid" do
      user = build(:user, :password => nil)
      expect(user).not_to be_valid
    end
  end
  describe "user associations" do
    let(:user){ build(:user) }
    let(:num_secret) { 3 }

    it "responds to secrets methods" do
      expect(user).to respond_to(:secrets)
    end
    it "secrets returns empty array by default" do
      expect(user.secrets).to eq([])
    end
    it "user creates secrets" do
      user.secrets = create_list(:secret, num_secret)
      user.save!
      expect(user.secrets.count).to eq(num_secret)
    end
  end
end
