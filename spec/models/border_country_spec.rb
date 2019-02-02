describe BorderCountry do
  it { is_expected.to belong_to(:country) }
  it { is_expected.to belong_to(:border_country).class_name('Country') }

  it { is_expected.to validate_presence_of(:border_country) }

  it { is_expected.to delegate_method(:name_common).to(:border_country) }
end
