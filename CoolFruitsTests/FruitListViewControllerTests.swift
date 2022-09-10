//
//  FruitListViewControllerTests.swift
//  CoolFruitsTests
//
//  Created by Mario Alberto Barragán Espinosa on 10/09/22.
//

import XCTest
@testable import CoolFruits

final class FruitListViewControllerTests: XCTestCase {
    
    func test_viewDidLoad_requestFruits() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.completions.count, 1)
    }
    
    func test_loadFruitsCompletion_rendersSuccessfullyLoadedFruit() {
        let fruit0 = FruitModel.makeAppleFruitModel()
        let fruit1 = FruitModel.makeLemonFruitModel()
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.numberOfRenderedFruits(), 0)
        
        loader.completeFruitsLoading(with: [fruit0, fruit1], at: 0)
        XCTAssertEqual(sut.numberOfRenderedFruits(), 2)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, 
                         line: UInt = #line) -> (sut: FruitListViewController,
                                                 loader: FruitsLoaderSpy) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let sut: FruitListViewController = sb.instantiateViewController(identifier: String(describing: FruitListViewController.self))
        
        let loader = FruitsLoaderSpy()
        
        sut.fruitsLoader = loader
        
        return (sut, loader)
    }
}

extension FruitListViewController {
    func numberOfRenderedFruits() -> Int {
        return fruitsTableView.numberOfRows(inSection: 0)
    }
}
