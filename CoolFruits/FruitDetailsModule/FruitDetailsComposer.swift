//
//  FruitDetailsComposer.swift
//  CoolFruits
//
//  Created by Mario Alberto Barragán Espinosa on 10/09/22.
//

import UIKit

final class FruitDetailsComposer {
    static func composeWith(fruit: FruitModel) -> FruitDetailViewController {
        let detailViewController = FruitDetailViewController(fruit: fruit)
        detailViewController.title = fruit.name
        
        return detailViewController
    }
}
