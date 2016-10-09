require 'rails_helper'

describe Secret do
  describe "secret validations" do
    let( :secret ){ build(:secret) }
    it "is valid with default attributes" do
      expect(secret).to be_valid
    end
    it "is invalid without title" do
      secret = build(:secret, :title => nil)
      expect(secret).not_to be_valid
    end
    it "is invalid without body" do
      secret = build(:secret, :body => nil)
      expect(secret).not_to be_valid
    end
    it "is invalid without author" do
      secret.author = nil
      expect(secret).to be_invalid
    end
    it "is invalid with title length 3" do
      secret = build(:secret, title: "abc")
      expect(secret).not_to be_valid
    end
    it "is invalid with title length 25" do
      secret = build(:secret, title: "a" * 25)
      expect(secret).not_to be_valid
    end
    it "is valid with title length 4" do
      secret = build(:secret, :title => "a" * 4)
      expect(secret).to be_valid
    end
    it "is valid with title length 24" do
      secret = build(:secret, :title => "a" * 24)
      expect(secret).to be_valid
    end
    it "is invalid with body length 3" do
      secret = build(:secret, :body => 'abc')
      expect(secret).not_to be_valid
    end
    it "is invalid with body length 141" do
      secret = build(:secret, :body => 'a' * 141)
      expect(secret).to be_invalid
    end
    it "is valid with body length 4" do
      secret = build(:secret, :body => "abcd")
      expect(secret).to be_valid
    end
    it "is valid with body length 140" do
      secret = build(:secret, :body => "a" *140)
      expect(secret).to be_valid
    end
  end

  describe "associations" do
    let( :secret ){ build(:secret) }
    it "responds to author" do
      expect(secret).to respond_to(:author)
    end
    it "linking a valid user" do
      user = create(:user, :email => "abc@email.com")
      secret.author = user
      expect(secret).to be_valid
    end
    it "linking an invalid user" do
      secret.author_id = 123
      expect(secret).not_to be_valid
    end
  end

  describe "#last_five" do
    let(:num_secrets){ 10 }
    before do
      secrets = create_list(:secret, num_secrets)
    end
    it 'has num_secrets number secrets' do
      expect(Secret.all.size).to eq(10)
    end

    it 'has 5 secrets after using the method last_five' do
      expect(Secret.last_five.size).to eq(5)
    end

  end
end