require "rack/test"
require "json"
require_relative "../../app/api"
require_relative "../../config/sequel"

module APIHelpers
  include Rack::Test::Methods

  def app
    ExpenseTracker::API.new
  end
end

module ExpenseTracker
  # RSpec.configure do |config|
  #   config.include APIHelpers
  # end

  RSpec.shared_context "API helpers" do
    include Rack::Test::Methods

    def app
      ExpenseTracker::API.new
    end
  end
  RSpec.describe "Expense Tracker API", :db do
    include_context "API helpers"

    def post_expense(expense)
      post "/expenses", JSON.generate(expense)
      expect(last_response.status).to eq(200)

      parsed = JSON.parse(last_response.body)
      expect(parsed).to include("expense_id" => a_kind_of(Integer))

      expense.merge("id" => parsed.fetch("expense_id"))
    end

    it "records submitted expenses" do
      coffee = post_expense({
        "payee" => "Startbucks",
        "amount" => 5.75,
        "date" => "2017-06-10",
      })
      zoo = post_expense({
        "payee" => "Zoo",
        "amount" => 15.25,
        "date" => "2017-06-10",
      })
      gorceries = post_expense({
        "payee" => "Whole Foods",
        "amount" => 95.20,
        "date" => "2017-06-11",
      })

      get "/expenses/2017-06-10"
      expect(last_response.status).to eq(200)

      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly(coffee, zoo)
    end
  end
end