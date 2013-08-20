jquery-ajax-it
==============

A lightweight Ajax framework that simplifies ajax requests with the help of HTML 5 data attributes.

#### My Form:
```html
<div class="container">
    <form class="ajax" action="/api/test" method="post" data-cb="Namespace/testcb">
        <input type="submit"/>
    </form>
</div>
```

#### My Callback
```coffeescript
Namespace:
  testcb: (isSuccess, data) ->
    alert(isSuccess)
```

#### Ajax it!
```coffeescript
$('.container').ajaxIt()
```


