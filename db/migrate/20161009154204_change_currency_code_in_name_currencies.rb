class ChangeCurrencyCodeInNameCurrencies < ActiveRecord::Migration[4.2]
  def change
    rename_column :currencies, :currency_code, :code
  end
end
