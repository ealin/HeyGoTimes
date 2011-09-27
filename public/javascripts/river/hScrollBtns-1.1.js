/**
 * hScrollBtns 1.1 - jQuery 1.4.2 plugin
 * @url http://code.google.com/p/hscrollbtns/
 */
(function($) {

    $.fn.hScrollBtns = function(opts) {
        return this.each(function() {
            opts = $.extend( {}, $.fn.hScrollBtns.defaults, opts );
            var box = $(this);

            // only create elements once
            if ( box.data('hScrollBtns-timer') ) {
                return;
            }

            box.data('hScrollBtns-timer', null)
               .append('<div class="hScrollBtns-btn btn-w"></div><div class="hScrollBtns-btn btn-e"></div>')
               .mouseout( function(e){box.find('.hScrollBtns-btn').hide();} )
               .bind('mouseover mousemove scroll', function(e){ update(e, box, opts); }); // need mouseover here for Opera 10
            box.find('.btn-w').bind(opts.startEvent, function(){ startScroll(box, opts.step, opts.speed, -1);} )
               .bind(opts.stopEvent, function(){stopScroll(box);});
            box.find('.btn-e').bind(opts.startEvent, function(){ startScroll(box, opts.step, opts.speed, 1);} )
               .bind(opts.stopEvent, function(){stopScroll(box);});
        });
    };

    function update(e, box, opts) {
        if(box.height() <= opts.safeHeight) return;

        var btnH = box.find('.hScrollBtns-btn').height();  // NOTE: left/right buttons should share the same height
        var boxSL = box.scrollLeft();

        if( boxSL <= 0 ) {
            box.find('.btn-w:not(.btn-active)').hide();
            stopScroll(box);
        }
        else {
            box.find('.btn-w').show();
        }

        if( boxSL >= ( box.attr('scrollWidth')-box.attr('clientWidth') ) ) {
            box.find('.btn-e:not(.btn-active)').hide();
            stopScroll(box);
        }
        else {
            box.find('.btn-e').show();
        }

        // update botton position
        if(e.type!='scroll') {
            var top = ( e.pageY ) - btnH / 2;
            var offset = (opts.offset ? opts.offset : box.find('.hScrollBtns-btn').width()/2 );

            // don't put buttons (vertically) outside of the box
            if( top < box.offset().top ) {
                top = box.offset().top;
            }
            if( top + btnH > box.offset().top + box.height() ) {
                top = box.offset().top + box.height()- btnH;
            }

            if( !$(e.target).hasClass('hScrollBtns-btn') ) {
                box.find('.btn-w').css({ 'top': top, 'left': box.offset().left - offset });
                box.find('.btn-e').css({ 'top': top, 'left': box.offset().left + box.width() - box.find('.btn-e').width() + offset });
            }
        }

    }

    function startScroll(o, step, speed, dir) {
        $(o).scrollLeft( $(o).attr('scrollLeft') + step * dir );
        stopScroll(o);
        if(dir > 0) { $(o).find('.btn-e').addClass('btn-active'); }
        else { $(o).find('.btn-w').addClass('btn-active'); }
        o.data('hScrollBtns-timer', setTimeout(function() { startScroll(o, step, speed, dir); }, speed) );
    }

    function stopScroll(o) {
        $(o).find('.hScrollBtns-btn').removeClass('btn-active');
        clearTimeout( o.data('hScrollBtns-timer'));
    }

    $.fn.hScrollBtns.defaults = {
        step       : 20,            // scroll distance
        speed      : 25,            // number of milliseconds to scroll by 1 step
        offset     : null,          // horizontally push buttons away from box, if null, use the half of button width
        startEvent : 'mousedown',   // event type(s) for buttons to start scroll
        stopEvent  : 'mouseup',     // event type(s) for buttons to stop scroll
        safeHeight : 0              // boxes with height less than this will not show any buttons (still have button elements but not interactive)
    };

})(jQuery);
