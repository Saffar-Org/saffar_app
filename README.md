# Saffar App
![Set of images](https://github.com/Saffar-Org/saffar_app/assets/37190888/9e9d9c71-e676-4850-9760-b27478defdaf)

## What is Saffar?
A Test Taxi booking application. 

Saffar is an open source project to showcase the use of Flutter with a Node JS backend (Saffar backend repo link [here](https://github.com/Saffar-Org/saffar_backend)) along with TomTom maps service (Google Maps alternative. Link [here](https://www.tomtom.com/products/maps/)).

The app uses Flutter as it's frontend framework, TomTom as it's map service, Hive as it's local storage and Razorpay as it's payment gateway. Clean architecture (Clean architecture lectures link [here](https://www.youtube.com/watch?v=dc3B_mMrZ-Q)) is used to keep the app modular and it's UI logic, Business logic and Data logic separate. It uses Bloc and Cubits state management which handles state in a clean and optimal manner. 

## Folder structure
* **core**: Contains all the components that are used throughout the app in multiple places
* **features**: Contains all the separate features used in the app
  * **feature_name**
    * **data**: Contains the components used in fetching and posting data from/to local and remote data sources
    * **domain**: Only the business logic is present here nothing else
    * **presenter**: UI and state code in present here
   
## TomTom maps service
TomTom maps service is a good alternative for Google Maps for testing your apps with maps. It contains all the major services that are needed for most of the apps. It doesn't have a dedicated SDK for flutter as of now i.e. when this README.md file is being written. (If in future a TomTom SDK for flutter is available please raise an issue to correct this README.md file). So, for now we have to work with APIs provided bt TomTom and using [flutter_map](https://pub.dev/packages/flutter_map).

## Other
If you are interested to see examples of real world app code then do follow. It is always nice to connect with fellow developers.
