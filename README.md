#  Movie OS Lite

This is a movie app for IOS that keep track of the most popular movies, the upcoming and now playing movies. This app also demonstrates the use of multiple libraries with a clean architecture for fetching the data from [The Movie Database](https://www.themoviedb.org/) API.

## Setting it up with your own API KEY

In the **TMDBClient.swift** file there is a property called `API_KEY`, initialize the _String_ with your own API KEY in the following line:

```Swift
//INSERT YOU OWN API KEY HERE
let API_KEY = "{INSERT YOU OWN API KEY HERE}"
```
## APIs

* [URLSession](https://developer.apple.com/documentation/foundation/urlsession) for networking.
* [Core Data](https://developer.apple.com/documentation/coredata) to save the favorites movies in app Data Base.
* [NWPathMonitor](https://developer.apple.com/documentation/network/nwpathmonitor) to monitor and react to network changes.
* [Safari Services](https://developer.apple.com/documentation/safariservices/) to show the trailers in **YouTube** without leaving the app.

## Search Movies

You can search any movie from [The Movie Database](https://www.themoviedb.org/) and save it in your favorite list. When you are not using the search bar there is a list of movie collections organized **by category** for a _quick search_. The results will appear immediately when the user start writing in the search bar and when scrolls to the bottom more movies will be added if they are more found for that search criteria.

![search 1](https://github.com/OscarSantosGH/imagesAndGifs/blob/master/movieOSLite/search1.jpg?raw=true "Search Image 1")
![search 2](https://github.com/OscarSantosGH/imagesAndGifs/blob/master/movieOSLite/search2.jpg?raw=true "Search Image 2")
![search 3](https://github.com/OscarSantosGH/imagesAndGifs/blob/master/movieOSLite/search3.jpg?raw=true "Search Image 3")

## Movie Details

This screen show details of the selected movie such as _Title_, _Rating_, _Release Date_, _Trailers_, _Overview_, _Gender Tags_ and the _Cast_. In the navigation bar there is an _Action button_ to **share** the movie trailer if is available. When a trailer is selected the app will show the trailer in **YouTube** embedded in a `SFSafariViewController`. There is a _Heart Button_ to *Save* the Movie in the app Data Base.

![movie details 1](https://github.com/OscarSantosGH/imagesAndGifs/blob/master/movieOSLite/details1.jpg?raw=true "Movie Details 1")
![movie details 2](https://github.com/OscarSantosGH/imagesAndGifs/blob/master/movieOSLite/details2.jpg?raw=true "Movie Details 2")

## Person Details

When the user select a cast member a _modal_ slide up and shows the details of that person such as _Name_, _Age_, _Place Of Birth_, _Biography_ and all the movies that person is known for, if one of those movies is selected the modal will be _dismiss_ and the Movie Detail will be updated with the new info. 

![person details 1](https://github.com/OscarSantosGH/imagesAndGifs/blob/master/movieOSLite/personDetails.jpg?raw=true "Person Details 1")

## Favorite List

This screen show all the movies saved by the user. Core Data is used to add and remove the favorites movies in the app database for offline use. When a movie is selected all the details will appear but data of that movie including the poster and backdrop images will came from the app database instead of downloading it from the internet.

![favorite](https://github.com/OscarSantosGH/imagesAndGifs/blob/master/movieOSLite/favorites.jpg?raw=true "Favorite Image")

## Dark Mode Support

The app was coded with Dark Mode in mind, all the colors used on the app are dynamic. 

![dark mode](https://github.com/OscarSantosGH/imagesAndGifs/blob/master/movieOSLite/darkMode.jpg?raw=true "Dark Mode")
![light mode](https://github.com/OscarSantosGH/imagesAndGifs/blob/master/movieOSLite/lightMode.jpg?raw=true "Light Mode")

## Coming Soon

* Support for multiple language.
* Show movie trailers in a floating mini player.
