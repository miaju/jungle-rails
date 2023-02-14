require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before do
      @cat1 = Category.find_or_create_by! name: 'Evergreens'
    end
    it "should save product with all fields" do
      @product = Product.create({name: 'Giant Tea', quantity: 1, price: 12999, category: @cat1})
      expect(@product.save!)
    end
    it "validates :name" do
      @product = Product.create({name: nil, quantity: 1, price: 12999, category: @cat1})
      expect{@product.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
    end
    it "validates :price" do
      @product = Product.create({name: 'Giant Tea', quantity: 1, category: @cat1})
      expect{@product.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Price cents is not a number, Price is not a number, Price can't be blank")
    end
    it "validates :quantity" do
      @product = Product.create({name: 'Giant Tea', quantity: nil, price: 12999, category: @cat1})
      expect{@product.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Quantity can't be blank")
    end
    it "validates :category" do
      @product = Product.create({name: 'Giant Tea', quantity: 1, price: 12999, category: nil})
      expect{@product.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Category must exist, Category can't be blank")
    end
  end
end