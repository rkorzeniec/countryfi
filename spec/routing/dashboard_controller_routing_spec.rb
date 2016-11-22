describe DashboardController do
  it { expect(get: '/dashboard/').to route_to(controller: 'dashboard', action: 'show') }
end
