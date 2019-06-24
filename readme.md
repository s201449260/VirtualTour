Virtual Tourist App

This app allows users specify travel locations around the world, and create virtual photo albums for each location. The locations and photo albums will be stored in Core Data. First, the user needs to log in to the app using their Udacity username and password.

The app has three view controller scenes:

- Login View: Allows the user to log in using their Udacity credentials.
- Travel Locations Map View: Allows the user to drop pins around the world
- Photo Album View: Allows the users to download and edit an album for a location

1- Login View

The login view accepts the email address and password that students use to login to the Udacity site. User credentials are not required to be saved upon successful login.
When the user taps the Login button, the app will attempt to authenticate with Udacity’s servers.

2- Travel Locations Map
Users will be able to zoom and scroll around the map using standard pinch and drag gestures.
The center of the map and the zoom level should be persistent. If the app is turned off, the map should return to the same state when it is turned on again.
Tapping and holding the map drops a new pin. Users can place any number of pins on the map.
When a pin is tapped, the app will navigate to the Photo Album view associated with the pin.

3- Photo Album
If the user taps a pin that does not yet have a photo album, the app will download Flickr images associated with the latitude and longitude of the pin.
If no images are found a “No Images” label will be displayed.
If there are images, then they will be displayed in a collection view.
While the images are downloading, the photo album is in a temporary “downloading” state in which the New Collection button is disabled. The app should determine how many images are available for the pin location, and display a placeholder image for each

- Requirements : 
1- Xcode 10.1 or later
2- Swift 4
3- iOS 8.1 or later
4- Udacity User
