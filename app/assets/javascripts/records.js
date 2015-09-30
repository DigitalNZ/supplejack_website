/*
 * The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
 * and is licensed under the GNU General Public License, version 3. Some components are 
 * third party components that are licensed under the MIT license or other terms. 
 * See https://github.com/DigitalNZ/supplejack_website for details. 
 * 
 * Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
 * http://digitalnz.org/supplejack
 */

(function() {
    'use strict';

    var Filters =  {};

    Filters = (function() {

      var setActiveFilters = function() {
        var active_filters = $('button.filter-unit');

        active_filters.each(function () { 
          var facet = $(this).data('facet');
          var filter = $(this).data('filter');
          // Find links and make them active
          var selector = '.tabs-content a[data-facet="'+facet+'"][data-filter="'+filter+'"]';
          
          $(selector).addClass('active');
          // disableFacets(facet);
        });
      }

      var updateFilters = function() {
        var href = cleanHref(),
            facet, filter, filters;

        filters = facetHash();
        
        for (var facet in filters) {
          if (filters[facet].length > 1) {
            // Add filters to or.
            for (var filter_values in filters[facet]) {
              href = href + "&or["+facet+"][]="+filters[facet][filter_values];
            }
          } else {
            // Add filter as i value.
            href = href + "&i["+facet+"]="+filters[facet][0];
          }
        }

        if (href != window.location.href) {
          window.location = href;
        } 
      }


      /**
      * Create a Hash of all the current filters.
      */
      var facetHash = function() {
        var facet_hash = {}, facet, filter_value

        $('.filter-unit').each(function() { 
          facet = $(this).data('facet');
          filter_value = $(this).data('filter');

          if(facet_hash[facet] == undefined) {
            facet_hash[facet] = [filter_value];
          } else {
            facet_hash[facet][facet_hash[facet].length] = filter_value;
          }
        });

        return facet_hash;
      }

      var cleanHref = function() {
        var current = window.location.href.split('?');
        var clean = current[0]+'?';
        var params = current[1].split('&');

        for (var i = 0; i < params.length; i++) {
          var filter = params[i].split('=');
          var search_params = ['text', 'tab', 'utf8', 'commit'];
          
          if ($.inArray(filter[0], search_params) > -1) {
            if (i > 0) {
              clean += "&"+params[i];
            } else {
              clean += params[i]
            }
          }
        };

        return clean;
      }

      var config = {
        init: (function() {
          var self = this;

          self.initTabs();
          self.initFilters();

          $.fn.justtext = function() {
            return $(this).clone().children().remove().end().text();
          };

          // Build the current filters for the page.
          setActiveFilters();
        })
        /**
         * change the active tab in the filters list
         */
        ,initTabs: (function() {
          var self = this,
              $tabs = $('ul.tabs li a, .quick-filters .more'),
              $tabsContent = $('.tabs-content .content');

          $tabs.on('click', function(event) {
            var $tab = $(this);

            $tabs.parent('li.active').removeClass("active");
            $tab.parent('li').addClass("active");

            $tabsContent.removeClass("active");
            $($tab.attr('href')).addClass('active');

            event.preventDefault();
            return false;
          });  
        })
        /**
         * find menu buttons and make them and their related dropdowns open and close when clicked
         */
        ,initFilters: (function() {
          var $menuBtn = $('button.menu');
          
          // $menuBtn.on('click', function(){
          //   var $btn = $(this),
          //       $menu = $btn.siblings('.menu');

          //   $btn.toggleClass('on');
          //   $menu.toggleClass('open');
          // });

          // Close button
          var $closeBtn = $('button.close');

          $closeBtn.on('click', function(){
            $('.menu.open').removeClass('open');
            $('.menu.on').removeClass('on');
            updateFilters();
          });

          //to add filters the right of the filter button
          var $filterUnit = $('.filter-container .content li a:not(.more)'),
              $filterBtn = $('.filter-btn');

          $filterUnit.on('click', function(){
            var $filter = $(this),
                facet = $filter.data('facet'),
                filter_value = $filter.data('filter'),
                facet_class = $filter.attr('class').split(' ')[0];

            if (!$filter.hasClass('disabled')) {
              if($filter.hasClass('active')) {
                $('#target-' + facet_class).remove();
                $('.'+facet_class).removeClass('active');
                $('.tabs-content a[data-facet="'+facet+'"]').removeClass('disabled');

              } else {
                $('.tabs-content a[data-facet="'+facet+'"][data-filter="'+filter_value+'"]').addClass('active');
                var $newFilterBtn = $('<button id="target-'+facet_class+'" data-filter="'+filter_value+'" data-facet="'+facet+'" class="filter-unit">'+$filter.justtext()+'</button>');

                $filterBtn.after($newFilterBtn);
                // disableFacets(facet);
              }
            }
          });

          $('.close').on('click', function(){
            $('.filter-btn').attr('value', "0");
            $('.filter-container').hide();
            $('.first-tab').addClass('active');
            $('.menu.on').removeClass('on');
          });

          // Open Close filters
          $('.filter-btn').on('click', function(){
            if ($(this).attr('value') == "0") {
              $('.filter-container').show();
              this.setAttribute('value', "1");
            } else {
              $('.filter-container').hide();
              this.setAttribute('value', "0");
               $(this).blur();
            }
            $(this).toggleClass('on');
          });

          // Remove the filter on click
          $('.filter-unit').on('click', function(){
            var $filter = $(this),
                facet = $filter.data('facet'),
                filter_value = $filter.data('filter');
            
            $('.tabs-content a[data-filter="'+filter_value+'"]').removeClass('active');
            $('.tabs-content a[data-facet="'+facet+'"]').removeClass('disabled');
            $filter.remove();
            updateFilters();  
          });
        })
      };

      return config;
    }());

    Filters.init();
}());

