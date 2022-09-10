//
//  FruitDetailViewController.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 19-07-22.
//

import Foundation
import UIKit

public final class FruitDetailViewController: UIViewController {
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var genusLabel: UILabel!
    @IBOutlet weak var nutritionLabel: UILabel!
    
    private let fruit: FruitModel
    
    init(fruit: FruitModel) {
        self.fruit = fruit
        super.init(nibName: "FruitDetailViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        familyLabel.text = "Family: \(fruit.family!)"
        genusLabel.text = "Genus: \(fruit.genus!)"
        nutritionLabel.text = getNutritionText(selectedFruit: fruit)
        
        if fruit.genus == "Citrus" {
            view.backgroundColor = .systemGreen
        }
    }
    
    func getNutritionText(selectedFruit: FruitModel) -> String {
        var text = String()
        text += "Sugar: " + String(selectedFruit.nutritions?.sugar ?? 0)
        text += "\n"
        text += "Calories: " + String(selectedFruit.nutritions?.calories ?? 0)
        text += "\n"
        text += "Fat: " + String(selectedFruit.nutritions?.fat ?? 0)
        return text
    }
}
