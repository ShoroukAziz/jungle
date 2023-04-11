require "rails_helper"

# :first_name, :last_name, :email, :password, :password_confirmation

RSpec.describe User, type: :model do
  before(:all) do
    @first_name = "Shorouk"
    @last_name = "Abdelaziz"
    @email = "example@email.com"
    @password = "123456"
    @password_confirmation = "123456"
  end

  describe "Validations" do
    describe "the happy path" do
      context "given all required fields correctly" do
        it "should save a new user to the database" do
          @user = User.new({ first_name: @first_name, last_name: @last_name, email: @email, password: @password, password_confirmation: @password_confirmation })
          # @user.save
          expect(@user.save).to be true
          expect(@user.id).not_to be nil
        end
      end
    end
    describe "first and last name fields" do
      context "given all required fields except first name" do
        it "shouldn't save and returns First name can't be blank error" do
          user = User.new({ last_name: @last_name, email: @email, password: @password, password_confirmation: @password_confirmation })
          expect(user.save).to be false
          expect(user.errors.full_messages).to include "First name can't be blank"
        end
      end

      context "given all required fields except last name" do
        it "shouldn't save and returns Last name can't be blank error" do
          user = User.new({ first_name: @first_name, email: @email, password: @password, password_confirmation: @password_confirmation })
          expect(user.save).to be false
          expect(user.errors.full_messages).to include "Last name can't be blank"
        end
      end
    end

    describe "password field" do
      context "given all required fields except password" do
        it "shouldn't save and returns Password can't be blank" do
          user = User.new({ first_name: @first_name, last_name: @last_name, email: @email, password_confirmation: @password_confirmation })
          expect(user.save).to be false
          expect(user.errors.full_messages).to include "Password can't be blank"
        end
      end

      context "given all required fields except password confirmation" do
        it "shouldn't save and returns Password confirmation can't be blank error" do
          user = User.new({ first_name: @first_name, last_name: @last_name, email: @email, password: @password })
          expect(user.save).to be false
          expect(user.errors.full_messages).to include "Password confirmation can't be blank"
        end
      end

      context "given a non-matching password and password confirmation" do
        it "shouldn't save and returns Password confirmation doesn't match Password error" do
          user = User.new({ first_name: @first_name, last_name: @last_name, email: @email, password: @password, password_confirmation: "654321" })
          expect(user.save).to be false
          expect(user.errors.full_messages).to include "Password confirmation doesn't match Password"
        end
      end

      context "given a password that's less than 6 charachters" do
        it "shouldn't save and returns Password is too short (minimum is 6 characters) error" do
          user = User.new({ first_name: @first_name, last_name: @last_name, email: @email, password: "1234", password_confirmation: "1234" })
          expect(user.save).to be false
          expect(user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
        end
      end
    end

    describe "email field" do
      context "given all required fields except email" do
        it "shouldn't save and returns Email can't be blank error" do
          user = User.new({ first_name: @first_name, last_name: @last_name, password: @password, password_confirmation: @password_confirmation })
          expect(user.save).to be false
          expect(user.errors.full_messages).to include "Email can't be blank"
        end
      end
      context "given an email that already exists (case insensitive)" do
        it "shouldn't save and raises a unique constraint error" do
          user_1 = User.create({ first_name: @first_name, last_name: @last_name, email: @email, password: @password, password_confirmation: @password_confirmation })

          user_2 = User.new({ first_name: @first_name, last_name: @last_name, email: @email, password: @password, password_confirmation: @password_confirmation })
          expect { user_2.save }.to raise_error(ActiveRecord::RecordNotUnique)

          user_3 = User.new({ first_name: @first_name, last_name: @last_name, email: "EXAMPLE@EMAIL.com", password: @password, password_confirmation: @password_confirmation })
          expect { user_3.save }.to raise_error(ActiveRecord::RecordNotUnique)
        end
      end
    end
  end

  describe ".authenticate_with_credentials" do
    context "Given a correct email and password" do
      it "Should authinticate the user and returns the correct user" do
        @user = User.create({ first_name: @first_name, last_name: @last_name, email: @email, password: @password, password_confirmation: @password_confirmation })
        authinticated_user_id = User.authenticate_with_credentials(@email, @password).id
        expect(authinticated_user_id).to equal @user.id
      end
    end

    context "Given a correct email in differend case" do
      it "Should authinticate the user and returns the correct user" do
        @user = User.create({ first_name: @first_name, last_name: @last_name, email: "eXample@domain.COM", password: @password, password_confirmation: @password_confirmation })
        authinticated_user_id = User.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM", @password).id
        expect(authinticated_user_id).to equal @user.id
      end
    end

    context "Given a correct email with white spaces" do
      it "Should authinticate the user and returns the correct user" do
        @user = User.create({ first_name: @first_name, last_name: @last_name, email: "example@domain.com", password: @password, password_confirmation: @password_confirmation })
        authinticated_user_id = User.authenticate_with_credentials(" example@domain.com ", @password).id
        expect(authinticated_user_id).to equal @user.id
      end
    end

    context "Given a correct email and a wrong password" do
      it "Should not authinticate the user and returns nil" do
        authinticated_user = User.authenticate_with_credentials(@email, "123")
        expect(authinticated_user).to be nil
      end
    end

    context "Given a non-existing email" do
      it "Should not authinticate the user and returns nil" do
        authinticated_user = User.authenticate_with_credentials("email@gmail.com", @password)
        expect(authinticated_user).to be nil
      end
    end
  end
end
