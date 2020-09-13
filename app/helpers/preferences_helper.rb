# frozen_string_literal: true

module PreferencesHelper
  def countries_all?(user)
    user.countries_cluster == Users::PreferencesForm::COUNTRIES[:all]
  end

  def countries_independent?(user)
    user.countries_cluster == Users::PreferencesForm::COUNTRIES[:independent]
  end

  def countries_un_member?(user)
    user.countries_cluster == Users::PreferencesForm::COUNTRIES[:un]
  end
end
