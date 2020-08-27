# Description

-------------------------------------------
our client is an online marketplace, here is a sample of some of the products available on our site:

```
Product code  | Name                   | Price
----------------------------------------------------------
001           | Lavender heart         | £9.25
002           | Personalised cufflinks | £45.00
003           | Kids T-shirt           | £19.95
```

Our marketing team want to offer promotions as an incentive for our customers to purchase these items.

If you spend over £60, then you get 10% of your purchase
If you buy 2 or more lavender hearts then the price drops to £8.50.

Our check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.

The interface to our checkout looks like this (shown in Ruby):

  co = Checkout.new(promotional_rules)
  co.scan(item)
  co.scan(item)
  price = co.total

Implement a checkout system that fulfills these requirements.

```
Test data
---------
Basket: 001,002,003
Total price expected: £66.78

Basket: 001,003,001
Total price expected: £36.95

Basket: 001,002,001,003
Total price expected: £73.76
--------------------------------------------
```

# Solution
Checkout takes array of rules and applies them in given order to all items whenever total needs to be calculated.
Each rule's `apply` methods accepts:

* items - list of all items scanned so far
* basket_total - prices of all items in basket with previous rules applied

## Dependencies
Code was implemented using **MRI Ruby 2.2.2**. Code uses keyword arguments, so it will not work with versions older then 2.0.
There is no dependencies of external libraries.

## Testing
To avoid installing dependencies tests are implemented with Ruby's Minitest library.

To run tests run following command from application's directory:

```bash
$ bin/test
```
To run individual test (in this case feature test):

```bash
ruby -Iapp:specs specs/features/checkout_with_promotions_spec.rb
```
### Test hierarchy

There are two kinds of tests:

* ones in `specs/app` are testing individual classes (unit tests)
* one in `specs/features` has tests that covers requirements from description (feature/functional tests)

## Trying out

To try out different scenarios I've included runner that let scan items (type product codes) and see baskets total and total with discount.

```bash
$ bin/run
```
and then just follow instructions

##Author

Arturs Meisters
27/08/2020
