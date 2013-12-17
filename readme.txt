This bit of Ruby is for parsing a set of shopping carts in the format:

BLANK LINE (or line starting with "Input")
(quantity) (item name) at (price per item)
(quantity) imported (item name) at (price per item)
etc...
BLANK LINE

...from an input.txt file.
It will keep any blank lines or lines that start with "Input" intact,
but change "Input" to "Output."

The base sales tax rate is 10%.
The store sells three types of tax-exempt items: books, chocolate, and pills.
Imported items are subject to an additional 5% tax regardless of exempt status.

Thanks for reading!

Melody
