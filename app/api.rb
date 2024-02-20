require "sinatra/base"
require "json"
require_relative "ledger"

module ExpenseTracker
  class API < Sinatra::Base
    def initialize(ledger: Ledger.new)
      @ledger = ledger
      super()
    end

    post "/expenses" do
      expense = JSON.parse(request.body.read)
      result = @ledger.record(expense)

      return JSON.generate("expense_id" => result.expense_id) if result.success?

      status 422
      JSON.generate("error" => result.error_message) 
    end

    get "/expenses/:date" do
      JSON.generate(["as"])
    end
  end
end
