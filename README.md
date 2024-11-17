# Sky Wizard iOS

<p>
<img src="https://img.shields.io/badge/Swift-5.9-violet">
<img src="https://img.shields.io/badge/iOS-16.6-green">
<img src="https://img.shields.io/badge/XCode-16.0-blue">
</p>

<p>
  	<img src="https://github.com/hishd/SkyWizard-SwiftUI/blob/master/banners/iphone1.jpg" height="300">
	<img src="https://github.com/hishd/SkyWizard-SwiftUI/blob/master/banners/iphone2.jpg" height="300">
	<img src="https://github.com/hishd/SkyWizard-SwiftUI/blob/master/banners/iphone3.jpg" height="300">
	<img src="https://github.com/hishd/SkyWizard-SwiftUI/blob/master/banners/iphone4.jpg" height="300">
	<img src="https://github.com/hishd/SkyWizard-SwiftUI/blob/master/banners/iphone5.jpg" height="300">
	<img src="https://github.com/hishd/SkyWizard-SwiftUI/blob/master/banners/iphone6.jpg" height="300">
	<img src="https://github.com/hishd/SkyWizard-SwiftUI/blob/master/banners/iphone7.jpg" height="300">
</p>

<p>
  	<img src="https://github.com/hishd/SkyWizard-SwiftUI/blob/master/banners/ipad1.jpg" height="330">
	<img src="https://github.com/hishd/SkyWizard-SwiftUI/blob/master/banners/ipad2.jpg" height="330">
	<img src="https://github.com/hishd/SkyWizard-SwiftUI/blob/master/banners/ipad4.jpg" height="330">
	<img src="https://github.com/hishd/SkyWizard-SwiftUI/blob/master/banners/ipad6.jpg" height="330">
</p>

### Overview

Sky Wizard is a weather information application, developed for iOS devices. The app is open source and developed using **[open metro](https://open-meteo.com/)** api for weather updated and **[photon](https://photon.komoot.io)** for reverse geocoding.
Both the integrated api services are free for non-commercial use and required an api key based on the number of api calls.

**Note:** The application is mainly designed for iOS devices and therefore the iPad experience will be less optimized. The iPad experience will be improved in the future updates. Stay tuned 😉

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

### Animations

The animations are powered by Lottie library which is a powerful api rendering json and .lottie based animations. The weather icon animations used in the application are created by LottieLab (a platform creating Lottie animations). All the other animations are downloaded from Lottiefiles and credits goes to the related owners.

**Note: The animation files (.json files) can be found within the animations directory which is located in the other/animation directory tree.**

### 3D Object (House Object)

The 3D house object is a SceneKit file (.scn) which is rendered using the SceneKit api.  The object does not have any lights by default and two omni lights are directed towards the object to create the lighting. These omni light nodes are manipulated during the runtime to update the lighting intensity based on the weather conditions to mimic the available sunlight behavior on a real environment.

The default behavior of the object such as rotation is disabled to avoid the pinch zoom, drag and y axis. Therefore the x axis rotation is handled through a **UIPanGestureRecognizer** and the objects rotation angle is handled through the pan gesture's translation. The haptic feedback is performed by using **UIImpactFeedbackGenerator** which brings soft haptic feedback based on the rotation of the house object.

The 3D object was downloaded from the sketchfab platform (credits go to the owner), which contains thousands of 3D models. The file is edited and added some touches, such as adding a wizard on front door. The models can be downloaded as .usdz files and later can be opened and converted into .scn files using the Xcode's 3D editor.

### API's used

 -  **SceneKit** is used to render the house model.
 - **Lottie** is used to render the animations.
 - **DependencyInjector** is used to manage application dependencies using property wrappers.
 - **NetworkingService** is used to handle http network calls.

### Upcoming Features

- More 3D objects
- Getting weather updates on different cities (currently set to users location only)

### Visual Designs

These designs contains the static house image which is used on low performing devices to enhance application performance.

<p>
  <img src="https://github.com/hishd/SkyWizard/blob/master/resources/VisualDesigns/mockups.gif" height="300">
</p>
