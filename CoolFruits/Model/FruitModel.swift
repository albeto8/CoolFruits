//
//  FruitModel.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 19-07-22.
//

import Foundation

struct FruitModel: Codable {    
    let genus: String?
    let name: String
    let id: Int?
    let family, order: String?
    let nutritions: NutritionsModel?
    
    enum CodingKeys: String, CodingKey {
        case genus, name, id, family, order, nutritions
    }
}

struct NutritionsModel: Codable {
    let carbohydrates: Double?
    let protein: Double?
    let fat: Double?
    let calories: Int?
    let sugar: Double?
    
    enum CodingKeys: String, CodingKey {
        case carbohydrates, protein, fat, calories, sugar
    }
}
