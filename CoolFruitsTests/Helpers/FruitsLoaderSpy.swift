//
//  FruitsLoaderSpy.swift
//  CoolFruitsTests
//
//  Created by Mario Alberto Barragán Espinosa on 10/09/22.
//

@testable import CoolFruits

final class FruitsLoaderSpy: FruitsLoader {
    var completions = [(Result<[FruitModel], RequestManager.Error>) -> Void]()
    
    func getAllFruits(_ completion: @escaping (Result<[FruitModel], RequestManager.Error>) -> Void) {
        completions.append(completion)
    }
    
    func completeFruitsLoading(with fruits: [FruitModel], at index: Int) {
        completions[index](.success(fruits))
    }
}
