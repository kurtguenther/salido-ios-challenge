# Installation
You should be able to simply clone this repository and then install the pods.  See <http://cocoapods.org> for more details.

# Application overview
Whenever I dig into a codebase I always think there should be some light summary of how the application works - code + architecturally wise, but I usually don't find one.  

This is probably more verbose than I'd normally put for an application. 

*I also included some notes about my design choices in italics*

## Data Access

All data access is performed via the **ABCApiGateway** class.  The Gateway is accessed via the `sharedInstance` singleton method.

The ApiGateway is basically a wrapper around some AFNetworking operations.

*I could have chosen for the Gateway to be abstract, allowing us to swap out concrete implementations - like loading from a local DB or another API altogether.  But that seemed like overkill for this scenario*

## Cart

The cart is a peristed set items that the user wants to buy.  It contains (at a minimum) the quantity of each item.

There is an abstract **ABCCart** protocol which defines the methods that all carts must provide.

The only concrete implementation for this is the **ABCMemoryCart** protocol, though it is easy to add additional ones.

*It seemed prudent to do this here.  I provided the simple in-memory example, but it could be easily extended to provide a CoreData (or User Defaults for the lazy) persistence that will survive between runs of the application.  Or even it could be stored on the server to provide cart analytics*

*Additionally, this is probably the most controversial of my decisions here, but I could have implemented another Data Object for a Cart Item.  With gifting and discounts and such, that would alomst certainly have to be done*

*Also it's convenient that I store the Product object => Quantity (so I retain all the titles, etc without going back to the server) but in a more complex scenario I would just keep Product ID as the key*

## Views and Controllers

The application is a basic SplitViewController with a **ABCProductListViewController** showing all the items and an **ABCProductViewController** showing the details.

We use Storyboards for expediency.

## Dependencies

* __libextobjc__ - provides easy access to @weakify and @strongify, which IMO, everyone should be using to prevent retain cycles
* __SVPullToRefresh__ - provides the infinite scrolling
* __AFNetworking__ - for the usual

## Misc

* I didn't have time, but normally I set up an application wide Error Feedback View so that presenting errors is consistent across the app.  I find that to be super useful as the app gets more ungainly.