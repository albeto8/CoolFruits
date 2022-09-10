//
//  FruitModel+Fixture.swift
//  CoolFruitsTests
//
//  Created by Mario Alberto Barragán Espinosa on 10/09/22.
//

@testable import CoolFruits

extension FruitModel {
    static func makeAppleFruitModel() -> FruitModel {
        FruitModel(genus: "Malus", 
                   name: "Apple", 
                   id: 1, 
                   family: "Rosaceae", 
                   order: nil, 
                   nutritions: NutritionsModel(
                    carbohydrates: nil, 
                    protein: nil, 
                    fat: 0.4, 
                    calories: 52, 
                    sugar: 10.3))
    }
}
