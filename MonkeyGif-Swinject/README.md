
# MonkeyGif

** Scroll and save favorite gifs, Implementation of Giphy's APIs : Trending, Search and GetById

## Architecture

- MVVM -> Interactor -> Repository -> Controller
- API Queries are models
- API request are associated to their queries
- DI through constructors


## Run Config

- Debug, Release
- Test : Runs only test
- Preview :  in order to work on the UI without having to handle the 424 call error of too much requests


## UI

- The app is wrapped in UIRepresentable to be added with SwiftUI
- 2 UIViewControllers + 2 nibs
- 2 Custom cell view + nib
- UICollectionViewCompositionalLayout
- Decoractors
- Register Multiple Cells with parameters packs


## Routing

- GiphySceneCoordinator
- Each Coordinator injected into controllers - Deinitialized when destroyed


## Tests

- URLProtocol mock for session environment, values saved in folder Mocks

 
## Libraries

- SwiftyGif to read gifs imported through Carthage as xcframework - SPM wasnt available.
- swift-async-algorithms -  Locally, updated ios version so it supports arm64 (previews and simulator usage)

## How to use

- The toggle button at the top leading defines what search should we achieve (global words or ids) 
- If the search returns no result, we can refresh the collection by scrolling down and fetch trending GIFS
- Here is a test ID : xT4uQulxzV39haRFjG
- The star button at the top trailing open the favorites saved
- To add a favorite, long press on it and on the context menu select add favorite

