export default class VisitedCountriesCharts {
  constructor() {
    this.toggle_unique_countries_chart();
    this.setup_listeners();
  }

  setup_listeners() {
    $('#all_countries').click(() => {
      this.toggle_all_countries_chart();
    });

    $('#unique_countries').click(() => {
      this.toggle_unique_countries_chart();
    });
  }

  toggle_all_countries_chart() {
    $('#unique_countries_chart').hide();
    $('#all_countries_chart').show();
    $('#all_countries').addClass('btn-info');
    $('#unique_countries').removeClass('btn-info');
  }

  toggle_unique_countries_chart() {
    $('#all_countries_chart').hide();
    $('#unique_countries_chart').show();
    $('#unique_countries').addClass('btn-info');
    $('#all_countries').removeClass('btn-info');
  }
}
