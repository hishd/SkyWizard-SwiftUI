# Sky Wizard iOS

<p>
<img src="https://img.shields.io/badge/Swift-5.9-violet">
<img src="https://img.shields.io/badge/iOS-16.6-green">
<img src="https://img.shields.io/badge/XCode-16.0-blue">
</p>

### Overview

Sky Wizard is a weather information application, developed for iOS devices. The app is open source and developed using **[open metro](https://open-meteo.com/)** api for weather updated and [photon](https://photon.komoot.io) for reverse geocoding.
Both the integrated api services are free for non-commercial use and required an api key based on the number of api calls.

### Project Structure

The codebase follows the **MV** (Model-View) pattern to create the resource structure. The SwiftUI views are communicating with the data stores to manage the dataflow and bindings with view properties.

The project component tree is shown below,

 - **Application** : This contains project level resources and dependencies. The Application enum is used as a namespace (as swift does't support namespaces by default).
 - **Presentation** : The layer mainly contains the main SwiftUI views, subviews and navigation logic. The representable contain the SCNView wrapped in a *UIViewRepresentable* type.
 - **Data** : This contains all the service related components, models and datastore to support the views. The services are abstracted to create mocks and to manage dependencies.
	 - Reachability: Monitoring internet connection changes
	 - Location: Managing the location events
	 - Geocoding: Fetching the location name based on current coordinates
	 - Weather: Fetching the weather data based on the current location coordinate
 - **Util** : The utilities contains the view modifiers and view extensions which is used in the project.
 - **Other** :  Contains project related files and resource files such as animations, 3d models and fonts

### Navigation

The navigation is handled by the Navigation stack which keeps track of the **AppRoute** type which is an enum containing all the navigation paths. The computed property ***content*** is an opaque type of view which is used to make the content based on navigation destination changes.

The ***navigation*** environment key is used to perform the navigation within the NavigationStack. This is implemented using SwiftUI's EnvironmentKeys and EnvironmentValues. Whenever a subview fires the *navigation* event, the closure in the root view *(SkyWizard_SwiftUIApp)* fill be called passing the called navigation type *(enum case)*. The type will be apended into the *routes* instance within the root view which is used by the NavigationStack. The ***navigationDestination*** view modifier will be called and the content of the newly added enum item will be used as the destination view.

### API's used

 -  **SceneKit** is used to render the house model.
 - **Lottie** is used to render the animations.
 - **DependencyInjector** is used to manage application dependencies using property wrappers.
 - **NetworkingService** is used to handle http network calls.

### Visual Designs
<p>
  <img src="https://github.com/hishd/SkyWizard/blob/master/resources/VisualDesigns/mockups.gif" height="300">
</p>
