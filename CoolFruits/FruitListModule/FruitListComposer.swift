//
//  FruitListComposer.swift
//  CoolFruits
//
//  Created by Mario Alberto Barragán Espinosa on 10/09/22.
//

import UIKit

final class FruitListComposer {
    static func composeWith(loader: FruitsLoader, 
                            selection: @escaping (FruitModel) -> Void) -> FruitListViewController {
        let controller = makeController()
        
        controller.fruitsLoader = RequestManager.shared
        controller.selection = selection
        
        return controller
    }
    
    private static func makeController() -> FruitListViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let controller: FruitListViewController = sb.instantiateViewController(identifier: String(describing: FruitListViewController.self))
        
        return controller
    }
}
