# frozen_string_literal: true

describe ExceptionsController, type: :request do
  describe 'GET /404' do
    before { get('/404') }

    it do
      expect(response).to have_http_status('404')
      expect(subject).to render_template('404')
    end
  end

  describe 'GET /422' do
    before { get('/422') }

    it do
      expect(response).to have_http_status('422')
      expect(subject).to render_template('422')
    end
  end

  describe 'GET /500' do
    before { get('/500') }

    it do
      expect(response).to have_http_status('500')
      expect(subject).to render_template('500')
    end
  end

  context 'with unsupported format' do
    %i[pdf json jpeg xml js xls].each do |format|
      before do
        get('/xkcd', headers: { CONTENT_TYPE: format })
      end

      it do
        expect(response).to have_http_status('406')
      end
    end
  end
end
