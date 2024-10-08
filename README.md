# Swinject Implemetation

This project is an example of an implementation of Swifinject in SwiftUI app, wrapped in an UIKit Content.
The project contains the Main app and a DIWrapper, wrapping the Swifinject library.

## Have a look

### Here we set up the DI from the AppDelegate

    @UIApplicationMain
    class AppDelegate: NSObject, UIApplicationDelegate, UISceneDelegate, ObservableObject, UIEntryPoint {
    
        var assembledApp: AssembledApp!
        var window: UIWindow?
        
        var rootViewController: UIViewController? {
            didSet {
                window?.rootViewController = rootViewController
                window?.makeKeyAndVisible()
            }
        }
    
        override init() {
            super.init()
            self.assembledApp = .init(uiEntryPoint: self, di: buildDI())
        }
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            return true
        }
    
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            let sceneConfiguration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
            sceneConfiguration.delegateClass = AppDelegate.self
            return sceneConfiguration
        }

      // Initiliaze the DI
        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = scene as? UIWindowScene else {
                return
            }
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            if runSwiftUI {
                let view = ContentView().environmentObject(self)
                self.rootViewController = UIHostingController(rootView: view)
            } else {
                self.assembledApp?.startUIKitApp()
            }
        }

      // Helper method used to get the root view of the SwiftUI app
        func start() -> some View {
            guard let assembledApp else {
                fatalError("App not built !")
            }
            return assembledApp.startSwiftUiApp()
        }
    }
    
### Here all the objects are initialized

    func buildDI() -> DiBuilder {
          let di: DI = .init()
          return di
          // MARK: - Core
              .add(rootContainer)
              .add(sessionContainer)
              .add(appkeysContainer)
          // MARK: - Factories
              .add(viewModelFactoryContainer)
              .add(viewControllerFactoryContainer)
          // MARK: - ViewModels
              .add(appViewModelContainer)
              .add(favoriteViewModelContainer)
          // MARK: - ViewControllers
              .add(appViewControllerContainer)
              .add(favoriteViewControllerContainer)
          // MARK: - Businness
              .add(interactorContainer)
              .add(repositoryContainer)
              .add(persistenceControllerContainer)
              .add(gifControllerContainer)
          // MARK: - Routes
              .add(favoriteCoordinatorContainer)
              .add(appCoordinatorContainer)
              .makeAssembler { di in
                  let coordinator = di.resolve(GiphySceneCoordinator.self, name: AppViewController.name)
                  coordinator.start()
                  return coordinator.navigationController
              }
    }
    
### Tricks 
In order not to create every object manually we can add factories. And use the factories throught the @Environment value.

    protocol ViewControllerFactory: AnyObject {
        func makeAppViewController<
            Coordinator: GiphySceneCoordinator,
            ViewController: ViewControllerProtocol
        >(
            vm: ViewController.ViewModel,
            coordinator: Coordinator
        ) -> ViewController where Coordinator == ViewController.Coordinator
    }
    
    final class ViewControllerFactoryImpl: ViewControllerFactory {
        
        func makeAppViewController<
            Coordinator: GiphySceneCoordinator,
            ViewController: ViewControllerProtocol
        >(
            vm: ViewController.ViewModel,
            coordinator: Coordinator
        ) -> ViewController where Coordinator == ViewController.Coordinator {
            ViewController.build(coordinator: coordinator, viewModel: vm)
        }
    }


  ### Examples of object initilization for DI

  
  Basic initizalition:

    let rootContainer = AssemblyContainer(scope: .container) { _ in
      UINavigationController()
    }

  Protocol type initizalition:

    var interactorContainer = AssemblyContainer(scope: .weak, type: ApiInteractorProtocol.self) { r in
      let repository = r.resolving(GifRepositoryProtocol.self)
      return ApiInteractor(repository: repository)
    }

  Protocol type initizalition with name key, when the protocol is multiple times use:

    var favoriteCoordinatorContainer = AssemblyContainer(scope: .weak, name: FavoriteViewController.name, type: GiphySceneCoordinator.self) { r in
    let root = r.resolving(UINavigationController.self)
    let favoriteVM = r.resolving((any FetchingViewModelProtocol).self, name: FavoriteViewController.name) as? FavoriteViewController.ViewModel
    assert(favoriteVM != nil, "\(FavoriteViewController.ViewModel.self) not injected" )
    return FavoriteViewControllerCoordinator(navigationController: root, favoriteVM: favoriteVM!)
    } circularDependency: { r, coordinator in
        let vc = r.resolving(FavoriteViewController.self)
        coordinator.viewController = vc
    }

    

