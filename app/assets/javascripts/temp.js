/*
 * The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
 * and is licensed under the GNU General Public License, version 3. Some components are 
 * third party components that are licensed under the MIT license or other terms. 
 * See https://github.com/DigitalNZ/supplejack_website for details. 
 * 
 * Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
 * http://digitalnz.org/supplejack
 */


// Add 
$('.toggle-add-panel').click(function() {
   $(this).parent('.add-panel').find('.add-panel-inset').slideToggle();
   $(this).parent('.add-panel').toggleClass('add-panel-active');
});


// 
$(document).ready(function(){ 
   var editor = new MediumEditor('.editable');
});
