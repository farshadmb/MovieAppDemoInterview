# MovieAppDemoInterview

`MovieAppDemoInterview` is a Swift and UIKit client App for represent Movie Demo Test using GitHub Tmdb API with authentication. Application contains the three layers which are the `DataLayer`, `Domain Layer` and `Presentation Layer`. 

Also, app supports the dark theme.

## Requirements

- Xcode 15.0 or laster.
- Swift 5.9 or later.
- iOS 15 or later.

## Installation 

- Step 1: 
  Download or clone the project github repository
  
  `$ git clone https://github.com/farshadmb/MovieAppDemoInterview.git`

- Step 2:
  Install Cocoapods via `$ gem install cocoapods --user-install`
  
  then run ``` $ pods install ``` command.
  
- Step 3: 
   Open ```MovieDemoApp.xcworkspace``` 

- Step 4:
    Open ```AppConfig``` and put your api key otherwise you could not build the project.

- Step 5: 
    Run and enjoy the app.
    
## Technology use in this project
* UIKit
* Swift  
* RxCocoa 
* RxSwift 
* Clean Code 
* Clean Arch
* Modern MVVM
* github action, *see [action](../../actions) tab* 


## - Gitwokflow 
Use atlasian gitwork workflow
**from latest to earlier:**

Release v1 [#12](../../pull/12)

Bugfix: UI Styles [#11](../../pull/11)

Fix pods libs warnings [#10](../../pull/10)

Fix loading indicator bug on list and detail scene [#9](../../pull/9)

Fix movie detail dto for backdrop path [#8](../../pull/8)

Movie Details Feature [#7](../../pull/7)

Image url Builder & Downloaders [#6](../../pull/7)

Search Movie Feature [#5](../../pull/7)

Feature Movie List [#4](../../pull/7)

Base Components [#3](../../pull/7)

Data Layers features [#2](../../pull/7)

Feature Infrastructure [#1](../../pull/7)