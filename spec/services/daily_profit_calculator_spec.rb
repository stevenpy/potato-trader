require "rails_helper"

RSpec.describe DailyProfitCalculator do
  describe "#call" do
    let(:date) { "2022-08-22".to_date }
    let(:calculator) { described_class.new(date) }

    context "when prices exist for the date" do
      before do
        PotatoPrice.create!([
          {time: "2022-08-22T09:00:00.000Z", value: 2},
          {time: "2022-08-22T09:10:02.800Z", value: 9},
          {time: "2022-08-22T09:20:03.800Z", value: 12}
        ])
      end

      it "calculates maximum profit correctly" do
        expect(calculator.call).to eq(1000.0)
      end

      it "returns zero when prices only decrease" do
        PotatoPrice.delete_all
        PotatoPrice.create!([
          {time: "2022-08-22T09:00:00.000Z", value: 10},
          {time: "2022-08-22T09:10:02.800Z", value: 8},
          {time: "2022-08-22T09:20:03.800Z", value: 5}
        ])

        expect(calculator.call).to eq(0.0)
      end
    end

    context "when no prices exist for the date" do
      it "raises NoDataAvailableError" do
        expect { calculator.call }.to raise_error(ApiErrors::NoDataAvailableError)
      end
    end
  end
end
