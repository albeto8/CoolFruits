//
//  SceneDelegate.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 12-07-22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController(rootViewController: makeController())
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func makeController() -> FruitListViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let controller: FruitListViewController = sb.instantiateViewController(identifier: String(describing: FruitListViewController.self))
        
        return controller
    }
}

