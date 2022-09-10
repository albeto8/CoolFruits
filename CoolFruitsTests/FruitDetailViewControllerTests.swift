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
        let sut = makeSUT(with: FruitModel.makeAppleFruitModel())
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.familyLabel.text, "Family: Rosaceae")
        XCTAssertEqual(sut.genusLabel.text, "Genus: Malus")
        XCTAssertEqual(sut.nutritionLabel.text, "Sugar: 10.3\nCalories: 52\nFat: 0.4")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(with fruit: FruitModel,
                         file: StaticString = #file,
                         line: UInt = #line) -> FruitDetailViewController {
        let sut = FruitDetailViewController(fruit: fruit)
        
        return sut
    }
}
