require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "saves valid user" do 
      user = User.create(name: "Mia", email: 'mia@indygecko.com', password: "12335111", password_confirmation: "12335111")
      expect(user.save!)
    end
    it "validate password fields" do
      user = User.create(name: "Mia", email: 'mia@indygecko.com', password: "12335111")
      expect{user.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password confirmation can't be blank")
      
    end
    it "should have password and confirm password be the same" do 
      user1 = User.create(name: "Mia", email: 'mia@indygecko.com', password_confirmation: "12351111")
      user2 = User.create(name: "Mia", email: 'mia.1@indygecko.com', password: "12335111", password_confirmation: "12351111")
      expect{user1.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password can't be blank, Password confirmation doesn't match Password, Password is too short (minimum is 6 characters)")
      expect{user2.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password confirmation doesn't match Password, Password confirmation doesn't match Password")
    end
    it "should have unique email (case insenstive)" do 
      user1 = User.create(name: "Mia", email: 'mia@indygecko.com', password: "12335111", password_confirmation: "12335111")
      user2 = User.create(name: "Mia", email: 'mia@indygecko.com', password: "12335111", password_confirmation: "12335111")
      user3 = User.create(name: "Mia", email: 'MIA@inDygecko.com', password: "12335111", password_confirmation: "12335111")
      user1.save!
      expect{user2.save!}.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Email has already been taken')
      expect{user3.save!}.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Email has already been taken')
    end
    it "should have minimum password length" do 
      user = User.create(name: "Mia", email: 'mia.1@indygecko.com', password: "123", password_confirmation: "123")
      expect{user.save!}.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Password is too short (minimum is 6 characters)')
    end
  end
  describe '.authenticate_with_credentials' do
  end
end
