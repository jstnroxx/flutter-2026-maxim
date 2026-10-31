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

