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

   var Module =  {};

   Module = (function() {

      var resultWidth = function() {
         return ($(".gallery-record").length > 3)
      }

      var config = {
         initMasonry: (function() {
            var container = $('.gallery-container');
            container.masonry({
               itemSelector: '.gallery-record'
               ,isFitWidth: resultWidth()
            });

            container.imagesLoaded(function() {
               container.masonry('reload');
            });
         })
         ,initInfiniteScroll: (function() {
            var galleryContainer = $('.gallery-container'),
                notIE = ($('.ie8').length == 0 && $('.ie7').length == 0);

            if (notIE) {
               var callback = (function(elements) {
                  var newElements = $(elements),
                      spinner = $('#second-spinner').show();

                  galleryContainer.masonry('appended', newElements, true);

                  newElements.imagesLoaded(function(){
                     // show elems now they're ready
                     newElements.animate({ opacity: 1 });
                     spinner.hide();

                     newElements.each(function(index, elem) {
                        $(elem).find('a.unknown-height').removeClass('unknown-height');
                     });

                     galleryContainer.masonry('reload');
                  });
               });

               galleryContainer.infinitescroll({
                  navSelector: '#navigation',                 // selector for the paged navigation
                  nextSelector: '#navigation a[rel=next]',   // selector for the NEXT link (to page 2)
                  itemSelector: '.gallery-record',           // selector for all items you'll retrieve
                  errorCallback: function () { $(".infinite-spinner").hide(); },
                  loading: {
                     speed: 'fast',
                     msg: $('<div id="infscr-loading" class="infinite-spinner"><i class="fa fa-spinner fa-spin fa-4x"></i></div>')
                  }

               }, callback);

            }
         })
      };

      return config;
   })();

   Module.initMasonry();
   Module.initInfiniteScroll();
}());




