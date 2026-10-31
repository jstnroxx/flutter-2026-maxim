# Level 1
When passing down the total value of the cart from the
owner above down to the badge, it required mutation of 2
constructors: CartBadge (cart_badge.dart), and BooksScreen
(books_screen.dart), main.dart was also touched, when I passed
the total value inside the route call.

# Level 3
context.read\<Cart\>() on a method instead of context.watch\<Cart\>()
returns:\
"Tried to listen to a value exposed with provider, from
outside of the widget tree."

# Level 4
CartBadge rebuilds with "watch()": 3.\
CartBadge rebuilds with "select()": 1.

# Where does it live?
The cart: provided. The Books screen, the badge in its AppBar and the Cart
screen on another route all need it, and the Cart screen changes it. In
Level 1 it needed an extra parameter through three widgets just to reach
the badge. A model above MaterialApp reached with provider avoids that.

The search text in the Books AppBar: ephemeral. Only the search field and
the list it filters read it, and both sit inside the Books screen. Nobody
on another route cares, and it's fine for it to reset when the screen is
closed. It stays in the State of the widget that owns the field.

Whether the Cart screen's total is expanded or collapsed: ephemeral. It is
purely visual, only that one widget reads or changes it, and nothing is
lost if it resets. It stays in the State of that widget.

Theme mode (dark-mode switch): provided. MaterialApp reads it to build the
theme for every route, while the switch that changes it sits on a settings
screen. It's needed above all screens and changed from below, so it lives in
a model above MaterialApp.

