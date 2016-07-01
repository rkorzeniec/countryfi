(function() {
  var Alert;

  /*
   * @class Alert
   */

  Alert = function() {
    return this;
  };

  Alert.DEFAULTS = {
    type: 'warning',
    close_btn: true,
    classes: false,
    namespace: 'pa_page_alerts',
    animate: true,
    auto_close: false,
    container: 'content-wrapper',
    inner_container: 'pa-page-alerts-box'
  };

  Alert.TYPES_HASH = {
    warning: '',
    danger: 'alert-danger',
    success: 'alert-success',
    info: 'alert-info'
  };


  /*
   * Initialize plugin.
   */

  Alert.prototype.init = function() {
    var self;
    self = this;
    return $('body').on('click.pa.alerts', '.' + Alert.DEFAULTS.inner_container + ' .close', function() {
      self.close($(this).parents('.alert'));
      return false;
    });
  };


  /*
   * Add new alert.
   *
   * @param  {String} html
   * @param  {Object} options
   */

  Alert.prototype.add = function(html, options) {
    var $alert, $alerts, $box, height, padding_bottom, padding_top, alerts_container;

    options = $.extend({}, Alert.DEFAULTS, options || {});

    $alert = $('<div class="alert alert-page ' + options.namespace + ' ' + Alert.TYPES_HASH[options.type] + '" />').html(html);

    if (options.classes) {
      $alert.addClass(options.classes);
    }

    if (options.container) {
      alerts_container = $('#' + options.container);
    }

    if (options.close_btn) {
      $alert.prepend($('<button type="button" class="close" />').html('&times;'));
    }

    if (options.animate) {
      $alert.attr('data-animate', 'true');
    }

    $box = $('#' + options.container + ' .' + options.inner_container);
    if (!$box.length) {
      $box = $('<div class="' + options.inner_container + '" />').prependTo(alerts_container);
    }

    $alerts = $('#' + options.container + ' .' + options.inner_container + ' .' + options.namespace);

    height = $alert.css({
      visibility: 'hidden',
      position: 'absolute',
      width: '100%'
    }).appendTo('body').outerHeight();

    padding_top = $alert.css('padding-top');
    padding_bottom = $alert.css('padding-bottom');

    if (options.animate) {
      $alert.attr('style', '').css({
        overflow: 'hidden',
        height: 0,
        'padding-top': 0,
        'padding-bottom': 0
      });
    }

    if ($alerts.length) {
      $alerts.last().after($alert);
    } else {
      $box.append($alert);
    }

    if (options.animate) {
      return $alert.animate({
        'height': height,
        'padding-top': padding_top,
        'padding-bottom': padding_bottom
      }, 500, (function(_this) {
        return function() {
          $alert.attr('style', '');
          if (options.auto_close) {
            return $.data($alert, 'timer', setTimeout(function() {
              return _this.close($alert);
            }, options.auto_close * 1000));
          }
        };
      })(this));
    } else {
      return $alert.attr('style', '');
    }
  };


  /*
   * Close alert.
   *
   * @param  {jQuery Object} $alert
   */

  Alert.prototype.close = function($alert) {
    if ($alert.attr('data-animate') === 'true') {
      return $alert.animate({
        'height': 0,
        'padding-top': 0,
        'padding-bottom': 0
      }, 500, function() {
        if ($.data($alert, 'timer')) {
          clearTimeout($.data($alert, 'timer'));
        }
        return $alert.remove();
      });
    } else {
      if ($.data($alert, 'timer')) {
        clearTimeout($.data($alert, 'timer'));
      }
      return $alert.remove();
    }
  };


  /*
   * Close all alerts with specified namespace.
   *
   * @param  {Boolean} animate
   * @param  {String} namespace
   */

  Alert.prototype.clear = function(animate, namespace) {
    var $alerts, self;
    if (animate == null) {
      animate = true;
    }
    if (namespace == null) {
      namespace = 'pa_page_alerts';
    }
    $alerts = $('.' + Alert.DEFAULTS.inner_container + ' .' + namespace);
    if ($alerts.length) {
      self = this;
      if (animate) {
        return $alerts.each(function() {
          return self.close($(this));
        });
      } else {
        return $alerts.remove();
      }
    }
  };


  /*
   * Close all alerts.
   *
   * @param  {Boolean} animate
   */

  Alert.prototype.clearAll = function(animate) {
    var self;
    if (animate == null) {
      animate = true;
    }
    if (animate) {
      self = this;
      return $('.' + Alert.DEFAULTS.inner_container + ' .alert').each(function() {
        return self.close($(this));
      });
    } else {
      return $('.' + Alert.DEFAULTS.inner_container).remove();
    }
  };


  /*
   * Returns alerts container ID.
   */

  Alert.prototype.getContainerId = function() {
    return Alert.DEFAULTS.inner_container;
  };

  Alert.Constructor = Alert;

  PixelAdmin.addInitializer(function() {
    return PixelAdmin.initPlugin('alerts', new Alert);
  });

}).call(this);
