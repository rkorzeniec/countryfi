class ChangeCurrencyCodeInNameCurrencies < ActiveRecord::Migration
  def change
    rename_column :currencies, :currency_code, :code
  end
end
