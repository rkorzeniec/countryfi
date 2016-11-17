describe CheckinsController do
  it { expect(get: '/checkins').to route_to(controller: 'checkins', action: 'index') }
  it { expect(get: '/checkins/1').to route_to(controller: 'checkins', action: 'show', id: '1') }
  it { expect(get: '/checkins/new').to route_to(controller: 'checkins', action: 'new') }
  it { expect(post: '/checkins').to route_to(controller: 'checkins', action: 'create') }
  it { expect(get: '/checkins/1/edit').to route_to(controller: 'checkins', action: 'edit', id: '1') }
  it { expect(patch: '/checkins/1').to route_to(controller: 'checkins', action: 'update', id: '1') }
  it { expect(delete: '/checkins/1').to route_to( controller: 'checkins', action: 'destroy', id: '1') }
end
