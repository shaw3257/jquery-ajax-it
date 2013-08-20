(($, window, document) ->
  class Plugin
    constructor: (elem, options) ->
      @elem = elem
      @$elem = $(elem)
      @options = options
  
    defaults:
      ajaxClass: 'ajax'
    
    init: ->
      root = @
      root.config = $.extend {}, root.defaults, root.options
      @$elem.on 'submit', 'form.' + root.config.ajaxClass , (e) ->
        e.preventDefault()
        form = $(this)
        cb = root._getFunction(form.data("cb"))
        values = root._serializeObject(form)
        $.ajax
          url: form.attr("action")
          type: form.attr("method")
          data: JSON.stringify(values)
          contentType: "application/json"
          success: (data) ->
            if($.isFunction(cb)) 
              cb.apply(form, [true, data])
          error: (data) ->
            if($.isFunction(cb))
              cb.apply(form, [false, data])
    
    _getFunction: (path)->
      return if !path
      paths = path.split('/')
      obj = window
      for i of paths
        path = paths[i]
        obj = obj[path]
      if $.isFunction(obj)
        return obj
      else
        return
    
    _serializeObject: (obj) ->
      o = {}
      a = obj.serializeArray()
      $.each a, ->
        if o[@name] isnt `undefined`
          o[@name] = [o[@name]]  unless o[@name].push
          o[@name].push @value or ""
        else
          o[@name] = @value or ""
      return o

  $.fn.ajaxIt = (options) ->
    @each ->
      new Plugin(this, options).init()

) jQuery, window, document
