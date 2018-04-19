import $ from 'jquery/src/jquery';

import '../js/shared/sidebar';

import './admin_style.scss';



$( document ).on('turbolinks:load', function() {
  $('.chosen-select').chosen({
  	width: '100%'
  });
});