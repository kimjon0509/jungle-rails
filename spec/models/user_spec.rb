require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    describe '#password and #password_confirmation' do
      it 'should save to data base if password and password_confirmation matches' do
        @user = User.new(name: 'Test',
          email: 'test@test.com',
          password: 'test123',
          password_confirmation: 'test123')
        @user.save!
      end
      it 'should give error message if password and password_confirmation does not match' do
        @user = User.new(name: 'Test',
          email: 'test@test.com',
          password: 'test124',
          password_confirmation: 'test123')
        @user.save
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        # expect(User.find_by(name: 'Test1')).to be_nil
      end
      it 'should give error message if password is missing' do
        @user = User.new(name: 'Test',
          email: 'test@test.com',
          password_confirmation: 'test123')
        @user.save
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'should give error message if password confirmation is missing' do
        @user = User.new(name: 'Test',
          email: 'test@test.com',
          password: 'test123')
        @user.save
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end
    end
    describe '#email' do
      it 'should not save to database if email already exists' do
        @user = User.new(name: 'Test',
          email: 'test@test.com',
          password: 'test123',
          password_confirmation: 'test123')
        @user.save

        @same_user = User.new(name: 'Test',
          email: 'test@test.com',
          password: 'test123',
          password_confirmation: 'test123')
        @same_user.save

        expect(@same_user.errors.full_messages).to include("Email has already been taken")

      end
      it 'should not save to database if email already exists (!casesenstive)' do
        @user = User.new(name: 'Test',
          email: 'test@test.COM',
          password: 'test123',
          password_confirmation: 'test123')
        @user.save

        @same_user = User.new(name: 'Test',
          email: 'TEST@TEST.com',
          password: 'test123',
          password_confirmation: 'test123')
        @same_user.save

        expect(@same_user.errors.full_messages).to include("Email has already been taken")
        end
      end

    describe '.authenticate_with_credentials' do
      it 'should login user if email and password matches' do
        @user = User.new(name: 'Test',
          email: 'test@test.com',
          password: 'test123',
          password_confirmation: 'test123')
        @user.save

        output = User.authenticate_with_credentials('test@test.com', 'test123')
        expect(output.email).to eq('test@test.com')
      end

      it 'should not login user if email and password does not match' do
        output = User.authenticate_with_credentials('test@test.com', 'test123')
        expect(output).to be nil
      end

      describe 'user types in a few spaces before and/or after their email address' do
        it 'should login user even if there are few spaces before and/or after their email address' do
          @user = User.new(name: 'Test',
            email: 'test@test.com',
            password: 'test123',
            password_confirmation: 'test123')
          @user.save
          output = User.authenticate_with_credentials('   test@test.com    ', 'test123')
          expect(output.email).to eq('test@test.com')
        end
      end

      describe 'user types in the wrong case for their email' do
        it 'should still be authenticated successfully' do
          @user = User.new(name: 'Test',
            email: 'test@Test.COM',
            password: 'test123',
            password_confirmation: 'test123')
          @user.save
          output = User.authenticate_with_credentials('TESt@Test.cOM', 'test123')
          expect(output.email).to eq('test@test.com')
        end
      end

    end
  end
end
