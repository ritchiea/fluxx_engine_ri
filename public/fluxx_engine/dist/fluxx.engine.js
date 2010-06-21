(function($){
  $.fn.extend({
    addFluxxCard: function(options, onComplete) {
      var options = $.fluxx.util.options_with_callback($.fluxx.card.defaults,options,onComplete);
      return this.each(function(){
        var $card = $.fluxx.card.ui.call($.my.hand, options).hide()
          .appendTo($.my.hand);
        $card
          .data({
            listing: $('.listing:eq(0)',  $card),
            detail:  $('.detail:eq(0)',   $card),
            box:     $('.card-box:eq(0)', $card)
          })
          .bind({
            'fluxx.card.complete': _.callAll(
              function(){$card.show().resizeFluxxCard()},
              options.callback
            ),
            'fluxx.card.load': options.onload
          });
        $card.triggerHandler('fluxx.card.load')
        $card.fluxxCardLoadListing({url: options.listing.url}, function(){
          $card.fluxxCardLoadDetail({url: options.detail.url}, function(){
            $card.triggerHandler('fluxx.card.complete');
          })
        });
        $.my.cards = $('.card');
      });
    },
    removeFluxxCard: function(options, onComplete) {
      var options = $.fluxx.util.options_with_callback({},options,onComplete);
      return this.each(function(){
        $(this)
          .bind('fluxx.card.unload', options.callback)
          .bind('fluxx.card.unload', function(e){$(e.target).remove(); $.my.cards = $('.card')})
          .triggerHandler('fluxx.card.unload');
      });
    },
    resizeFluxxCard: function(options, onComplete) {
      var options = $.fluxx.util.options_with_callback({},options,onComplete);

      $('.card-box', this)
        .height(
          $.my.cards.height(
            $.my.hand.innerHeight() -
            $.fluxx.util.marginHeight($.my.cards)
          ).innerHeight()
        )
        .each(function(){
          var $box      = $(this),
              $cardBody = $('.card-body', $box);
          $('.area', $cardBody).height(
            $cardBody.height(
              $cardBody.parent().innerHeight() -
              _.addUp($cardBody.siblings(), 'outerHeight')
            ).innerHeight()
          ).each(function(){
            var $area     = $(this),
                $areaBody = $('.body', $area);
            $areaBody.height(
              $areaBody.parent().innerHeight() -
              _.addUp($areaBody.siblings(), 'outerHeight')
            )
          });
        });

      return this;
    },
    
    /* Accessors */
    fluxxCard: function() {
      return this.data('card')
        || this.data('card', this.parents('.card:eq(0)').andSelf()).data('card');
    },
    fluxxCardListing: function() {
      return this.fluxxCard().data('listing');
    },
    fluxxCardDetail: function () {
      return this.fluxxCard().data('detail');
    },
    fluxxCardBox: function () {
      return this.fluxxCard().data('box');
    },
    
    /* Data Loaders */
    fluxxCardLoadContent: function (options, onComplete) {
      var defaults = {
        area: undefined,
        type: 'GET',
        url: null,
        data: {}
      };
      var options = $.fluxx.util.options_with_callback(defaults,options,onComplete);
      options.area.unbind('fluxx.area.complete').bind('fluxx.area.complete', options.callback);

      if (!options.url) {
        options.area.triggerHandler('fluxx.area.complete');
        return this;
      }
      
      $.ajax({
        url: options.url,
        type: options.type,
        data: options.data,
        success: function (data, status, xhr) {
          var $document = $('<div/>').html(data);
          $('.header', options.area).html($('#card-header', $document).html());
          $('.body',   options.area).html($('#card-body',   $document).html());
          $('.footer', options.area).html($('#card-footer', $document).html());
          options.area.triggerHandler('fluxx.area.complete');
        },
        error: function(xhr, status, error) {
          options.area.triggerHandler('fluxx.area.complete');
        }
      });
      
      return this;
    },
    
    fluxxCardLoadListing: function (options, onComplete) {
      var options = $.fluxx.util.options_with_callback({area: this.fluxxCardListing()},options,onComplete);
      return this.fluxxCardLoadContent(options);
    },
    
    fluxxCardLoadDetail: function(options, onComplete) {
      var options = $.fluxx.util.options_with_callback({area: this.fluxxCardDetail()},options,onComplete);
      return this.fluxxCardLoadContent(options);
    }
  });
  
  $.extend(true, {
    fluxx: {
      card: {
        defaults: {
          title: 'New Card',
          onload: $.noop,
          listing: {
            url: null
          },
          detail: {
            url: null
          }
        },
        attrs: {
          'class': 'card',
          id: function(){return _.uniqueId('fluxx-card-')}
        },
        ui: function(options) {
          return $('<li>')
            .attr($.fluxx.card.attrs)
            .html($.fluxx.util.resultOf([
              '<div class="card-box">',
                '<div class="card-header">',
                  $.fluxx.util.resultOf($.fluxx.card.ui.toolbar,  options),
                  $.fluxx.util.resultOf($.fluxx.card.ui.titlebar, options),
                '</div>',
                '<div class="card-body">',
                  $.fluxx.util.resultOf($.fluxx.card.ui.area, $.extend(options,{type: 'listing'})),
                  $.fluxx.util.resultOf($.fluxx.card.ui.area, $.extend(options,{type: 'detail'})),
                '</div>',
                '<div class="card-footer">',
                  'Card Footer',
                '</div>',
              '</div>'
            ]));
        }
      }
    }
  });
  $.fluxx.card.ui.toolbar = [
    '<div class="toolbar">',
      'min, close, etc',
    '</div>'
  ].join('');
  $.fluxx.card.ui.titlebar = function(options) {
    return [
      '<div class="titlebar">',
        options.title,
      '</div>'
    ];
  };
  $.fluxx.card.ui.area = function(options) {
    var types = ['area'];
    types.unshift(options.type);
    return [
      '<div class="', types.join(' '), '">',
        '<div class="header"></div>',
        '<div class="body"></div>',
        '<div class="footer"></div>',
      '</div>'
    ];
  };

  $(window).resize(function(e){
    $.my.cards.resizeFluxxCard();
  });
})(jQuery);
(function($){
  _.mixin({
    addUp: function (set, property) {
      var args = _.toArray(arguments).slice(2);
      return _.reduce($(set).get(), 0, function(m,i){
        return m + $(i)[property].call($(i), args);
      });
    },
    callAll: function () {
      var functions = _.toArray(arguments);
      return function() {
        var this_ = this;
        var args  = arguments;
        _.each(functions, function(f){f.call(this_, args)});
      }
    }
  });
  
  $.extend(true, {
    my: {
      cards: $()
    },
    fluxx: {
      config: {
        cards: []
      },
      util: {
        options_with_callback: function(defaults, options, callback) {
          if ($.isFunction(options)) {
            options = {callback: options};
          } else if ($.isPlainObject(options) && $.isFunction(callback)) {
            options.callback = callback;
          }
          return $.extend({callback: $.noop}, defaults || {}, options || {});
        },
        resultOf: function (value) {
          if (_.isString(value))   return value;
          if ($.isArray(value))    return _.map(value,function(x){return $.fluxx.util.resultOf(x)}).join('');
          if ($.isFunction(value)) return arguments.callee(value.apply(value, _.tail(arguments)));
          return value;
        },
        marginHeight: function($selector) {
          return parseInt($selector.css('marginTop')) + parseInt($selector.css('marginBottom'));
        }
      },
      logOn: true,
      log: function () {
        if (!$.fluxx.logOn) return;
        if (! this.logger) this.logger = (console && console.log ? _.bind(console.log, console) : $.noop);
        _.each(arguments, _.bind(function(a) { this.logger(a) }, this));
      }
    }
  });
})(jQuery);

jQuery(function($){
  $.my.body = $('body');
});(function($){
  $.fn.extend({
    fluxxStage: function(options, onComplete) {
      var options = $.fluxx.util.options_with_callback({}, options, onComplete);
      return this.each(function(){
        $.my.fluxx  = $(this).attr('id', 'fluxx');
        $.my.stage  = $.fluxx.stage.ui.call(this, options).appendTo($.my.fluxx.empty());
        $.my.hand   = $('#hand');
        $.my.stage.bind({
          'fluxx.stage.complete': _.callAll(
            function(){ $.my.hand.addFluxxCards({cards: $.fluxx.config.cards});},
            options.callback
          )
        });
        $.my.stage.triggerHandler('fluxx.stage.complete');
      });
    },
    removeFluxxStage: function(onComplete) {
      var options = $.fluxx.util.options_with_callback({}, onComplete);
      return this.each(function(){
        if (!$.my.stage) return;
        $(this).remove();
        $.my.stage.triggerHandler('fluxx.stage.unload');
        $.my.stage = undefined;
        $.my.hand  = undefined;
        $.my.cards = $();
        options.callback.call(this);
      });
    },
    resizeFluxxStage: function(options, onComplete) {
      if (!this.length) return this;
      var options = $.fluxx.util.options_with_callback({}, options, onComplete);
      var allCards = _.addUp($.my.cards, 'outerWidth', true);
      $.my.stage
        .width(allCards)
        .bind('fluxx.stage.resize', options.callback)
        .triggerHandler('fluxx.stage.resize');
      return this;
    },
    
    addFluxxCards: function(options) {
      var options = $.fluxx.util.options_with_callback({}, options);
      if (!options.cards.length) return this;
      $.each(options.cards, function() { $.my.hand.addFluxxCard(this) });
      return this;
    }
  });
  
  $.extend(true, {
    fluxx: {
      stage: {
        attrs: {
          id: 'stage'
        },
        ui: function(optoins) {
          return $('<div>')
            .attr($.fluxx.stage.attrs)
            .html($.fluxx.util.resultOf([
              $.fluxx.stage.ui.header,
              $.fluxx.stage.ui.cardTable,
              $.fluxx.stage.ui.footer
            ]));
        }
      }
    }
  });
  $.fluxx.stage.ui.header = [
    '<div id="header">',
      '<div id="logo"><a href=".">FLUXX</a></div>',
      '<ul class="actions">',
      '</ul>',
    '</div>'
  ].join('');
  $.fluxx.stage.ui.cardTable = [
    '<div id="card-table">',
      '<ul id="hand">',
      '</ul>',
    '</div>'
  ].join('');
  $.fluxx.stage.ui.footer = [
    '<div id="footer">Footer</div>'
  ].join('');
  
  $(window).resize(function(e){
    $.my.stage.resizeFluxxStage();
  });
})(jQuery);
