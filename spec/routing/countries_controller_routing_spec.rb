describe CountriesController do
  it { expect(get: '/countries/1').to route_to(controller: 'countries', action: 'show', id: '1') }
end
