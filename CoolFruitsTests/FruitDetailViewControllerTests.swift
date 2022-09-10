//
//  FruitDetailViewControllerTests.swift
//  CoolFruitsTests
//
//  Created by Mario Alberto Barragán Espinosa on 10/09/22.
//

@testable import CoolFruits
import XCTest

final class FruitDetailViewControllerTests: XCTestCase {

    func test_viewDidLoad_updatesLabelsWith() {
        let sut = makeSUT()
        SelectedFruit.fruit = FruitModel(genus: "Malus", 
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
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.familyLabel.text, "Family: Rosaceae")
        XCTAssertEqual(sut.genusLabel.text, "Genus: Malus")
        XCTAssertEqual(sut.nutritionLabel.text, "Sugar: 10.3\nCalories: 52\nFat: 0.4")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> FruitDetailViewController {
        let sut = FruitDetailViewController(nibName: "FruitDetailViewController", bundle: .main)
        
        return sut
    }
}
