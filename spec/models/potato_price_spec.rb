require "rails_helper"

RSpec.describe PotatoPrice, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      potato_price = PotatoPrice.new(
        time: Time.current,
        value: 10.5
      )
      expect(potato_price).to be_valid
    end

    describe "time" do
      it "is invalid without time" do
        potato_price = PotatoPrice.new(value: 10.5)
        potato_price.valid?
        expect(potato_price.errors[:time]).to include("can't be blank")
      end
    end

    describe "value" do
      it "is invalid without value" do
        potato_price = PotatoPrice.new(time: Time.current)
        potato_price.valid?
        expect(potato_price.errors[:value]).to include("can't be blank")
      end

      it "is invalid with zero value" do
        potato_price = PotatoPrice.new(
          time: Time.current,
          value: 0
        )
        potato_price.valid?
        expect(potato_price.errors[:value]).to include("must be greater than 0")
      end

      it "is invalid with negative value" do
        potato_price = PotatoPrice.new(
          time: Time.current,
          value: -1
        )
        potato_price.valid?
        expect(potato_price.errors[:value]).to include("must be greater than 0")
      end

      it "is valid with positive value" do
        potato_price = PotatoPrice.new(
          time: Time.current,
          value: 1.5
        )
        expect(potato_price).to be_valid
      end
    end
  end
end
