require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    describe 'valid input' do
      it 'should save to the database' do
        @category = Category.new(name: 'Laptop')
        @category.save
        @category.products.create(name: 'Macbook',price: 2400, quantity: 12)
      end
    end

    describe '#name' do
      it 'should not exist for new records' do
        @category = Category.new(name: 'Laptop')
        @category.save
        @products = @category.products.create(price: 2400, quantity: 12)
        expect(@products.name).to be_nil
      end

      it 'should raise an error' do 
        @category = Category.new(name: 'Laptop')
        @category.save!
        @product = @category.products.create(price: 2400, quantity: 12)
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end 
    end

    describe '#price' do
      it 'should not exist for new records' do
        @category = Category.new(name: 'Laptop')
        @category.save
        @products = @category.products.create(name: 'Macbook', quantity: 12)
        expect(@products.price).to be_nil
      end

      it 'should raise an error' do 
        @category = Category.new(name: 'Laptop')
        @category.save!
        @products = @category.products.create(name: 'Macbook', quantity: 12)
        expect(@products.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
      end 
    end

    describe '#quantity' do
      it 'should not exist for new records' do
        @category = Category.new(name: 'Laptop')
        @category.save
        @products = @category.products.create(name: 'Macbook', price: 2400)
        expect(@products.quantity).to be_nil
      end

      it 'should raise an error' do 
        @category = Category.new(name: 'Laptop')
        @category.save!
        @product = @category.products.create(price: 2400, name: 'Macbook')
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end 
    end

    describe '#category' do
      it 'should not exist for new records' do
        @products = Product.new(name: 'Macbook', price: 2400, quantity: 12)
        expect(@products.category).to be_nil
      end

      it 'should raise an error' do 
        @product = Product.new(name: 'Macbook', price: 2400, quantity: 12)
        @product.save
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end 
    end
  end
end
