require('chartkick');
require('chart.js');

import EasyPieChart from 'easy-pie-chart';
import VisitedCountriesCharts from '../dashboard/visited_countries_charts.js';
import svgPanZoom from 'svg-pan-zoom';
import Hammer from 'hammerjs';

window.VisitedCountriesCharts = VisitedCountriesCharts;
window.EasyPieChart = EasyPieChart;
window.svgPanZoom = svgPanZoom;
window.ssag = require('save-svg-as-png');
window.Hammer = Hammer;
