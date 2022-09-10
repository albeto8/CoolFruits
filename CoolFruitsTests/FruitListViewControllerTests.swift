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
        let (sut, spy) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(spy.completions.count, 1)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, 
                         line: UInt = #line) -> (sut: FruitListViewController,
                                                 loader: FruitsLoaderSpy) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let sut: FruitListViewController = sb.instantiateViewController(identifier: String(describing: FruitListViewController.self))
        
        let spy = FruitsLoaderSpy()
        
        sut.fruitsLoader = spy
        
        return (sut, spy)
    }    
}
