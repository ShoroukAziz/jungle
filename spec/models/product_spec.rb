require "rails_helper"

RSpec.describe Product, type: :model do
  before(:all) do
    @category = Category.new name: "trees"
    @category.save
  end

  context "given name, price, quantity and category" do
    it "should save a new product sucessfully with no errors" do
      product = Product.new({ name: "Mango Tree", quantity: 5, price: 5000, category_id: @category.id })
      saved_product = product.save
      expect(saved_product).to be true
      expect(product.errors.full_messages).to match_array([])
    end
  end

  context "given price, quantity, category and no name" do
    it "shouldn't save and returns Name can't be blank error" do
      product = Product.new({ category_id: @category.id, quantity: 5, price: 5000 })
      saved_product = product.save
      expect(saved_product).to be false
      expect(product.errors.full_messages).to include "Name can't be blank"
    end
  end

  context "given name, quantity, category and no price" do
    it "shouldn't save and returns Price can't be blank error" do
      product = Product.new({ name: "Mango Tree", category_id: @category.id, quantity: 5 })
      saved_product = product.save
      expect(saved_product).to be false
      expect(product.errors.full_messages).to include "Price can't be blank"
    end
  end

  context "given name, price, category and no quantity" do
    it "shouldn't save and returns Quantity can't be blank error" do
      product = Product.new({ name: "Mango Tree", category_id: @category.id, price: 5000 })
      saved_product = product.save
      expect(saved_product).to be false
      expect(product.errors.full_messages).to include "Quantity can't be blank"
    end
  end

  context "given name, price, quantity and no category" do
    it "shouldn't save and returns Category can't be blank error" do
      product = Product.new({ name: "Mango Tree", quantity: 5, price: 5000 })
      saved_product = product.save
      expect(saved_product).to be false
      expect(product.errors.full_messages).to include "Category can't be blank"
    end
  end
end
