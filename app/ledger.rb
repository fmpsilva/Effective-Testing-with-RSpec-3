require_relative "../config/sequel"

module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  class Ledger
    def record(expense)
      unless expense.key?("payee")
        message = "Invalid expense: `payee` is required"

        return RecordResult.new(false, nil, message)
      end

      expenses.insert(expense)
      id = expenses.max(:id)

      RecordResult.new(true, id, nil)
    end

    def expenses_on(date)
      expenses.where(date: date).all
    end

    private

    def expenses
      expenses ||= DB[:expenses]
    end
  end
end