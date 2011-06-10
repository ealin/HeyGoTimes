/*
 * SimpleModal OSX Style Modal Dialog
 * http://www.ericmmartin.com/projects/simplemodal/
 * http://code.google.com/p/simplemodal/
 *
 * Copyright (c) 2010 Eric Martin - http://ericmmartin.com
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Revision: $Id: osx.js 238 2010-03-11 05:56:57Z emartin24 $
 */

jQuery(function ($) {
	var OSX = {
		container: null,
		init: function () {
			$("input.osx, a.osx").click(function (e) {
				e.preventDefault();

        if (this.name == 'btn1')
        {
          $("#osx-modal-content").modal({
            overlayId: 'osx-overlay',
            containerId: 'osx-container',
            closeHTML: null,
            minHeight: 80,
            opacity: 65,
            position: ['0',],
            overlayClose: true,
            onOpen: OSX.open,
            onClose: OSX.close
          })
        }
        else if(this.name == 'btn2')
        {
          $("#osx-modal-content1").modal({
            overlayId: 'osx-overlay',
            containerId: 'osx-container',
            closeHTML: null,
            minHeight: 80,
            opacity: 65,
            position: ['0',],
            overlayClose: true,
            onOpen: OSX.open1,
            onClose: OSX.close
          })
        }
			});
		},
		open: function (d) {
			var self = this;
			self.container = d.container[0];

			d.overlay.fadeIn('slow', function () {
				$("#osx-modal-content", self.container).show();
				var title = $("#osx-modal-title", self.container);
				title.show();
				d.container.slideDown('slow', function () {
					setTimeout(function () {
						var h = $("#osx-modal-data", self.container).height()
							+ title.height()
							+ 20; // padding
						d.container.animate(
							{height: h}, 
							100,
							function () {
								$("div.close", self.container).show();
								$("#osx-modal-data", self.container).show();
							}
						);
					}, 100);
				});
			})
		},
    open1: function (d) {
			var self = this;
			self.container = d.container[0];

			d.overlay.fadeIn('fast', function () {
				$("#osx-modal-content1", self.container).show();
				var title = $("#osx-modal-title1", self.container);
				title.show();
				d.container.slideDown('fast', function () {
					setTimeout(function () {
						var h = $("#osx-modal-data1", self.container).height()
							+ title.height()
							+ 20; // padding
						d.container.animate(
							{height: h},
							100,
							function () {
								$("div.close", self.container).show();
								$("#osx-modal-data1", self.container).show();

                                // Ealin:  dropdownchecklist would help to make multiple-option as dropdown-checkbox-list
                                //
                                $("#area_filter").dropdownchecklist( { emptyText: "Please Select...", width: 150 });

							}

						);
					}, 100);
				});
			})
		},
		close: function (d) {
			var self = this; // this = SimpleModal object
			d.container.animate(
				{top:"-" + (d.container.height() + 20)},
				500,
				function () {
					self.close(); // or $.modal.close();
				}
			);
		}
	};

	OSX.init();

});