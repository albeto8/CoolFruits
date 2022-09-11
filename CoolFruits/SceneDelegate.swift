//
//  SceneDelegate.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 12-07-22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var navigationController = UINavigationController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let loader = RequestManager.shared
        
        navigationController = UINavigationController(rootViewController: FruitListComposer.composeWith(loader: loader, selection: navigateToDetail))
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func navigateToDetail(fruit: FruitModel) {
        let detailViewController = FruitDetailsComposer.composeWith(fruit: fruit)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

