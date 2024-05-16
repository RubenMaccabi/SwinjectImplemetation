//
//  ContentView.swift
//  MonkeyGif
//
//  Created by Ruben Mimoun on 19/03/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let apiKey: String
    
    var body: some View {
        AppRepresentable(apiKey: apiKey)
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
    }
}

struct AppRepresentable: UIViewControllerRepresentable {
    
    let apiKey: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller: GifControllerProtocol = GifController(controller: .shared)
        let repository: GifRepositoryProtocol = GifRepository(controller: controller, urlSession: .envSession)
        let interactor: ApiInteractorProtocol = ApiInteractor(repository: repository)
        let navController = UINavigationController()
        let appViewCoordinator = AppViewControllerCoordinator(navigationController: navController, apiKey: apiKey, apiInteractor: interactor)
        appViewCoordinator.start()
        return navController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

#Preview {
    let reader = PlistReader(keyList: .appKeys)
    let appKeys: AppKeys = reader.read()
    return ContentView(apiKey: appKeys.giphyApi)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
