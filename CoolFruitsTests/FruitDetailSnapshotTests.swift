//
//  FruitDetailSnapshotTests.swift
//  CoolFruitsTests
//
//  Created by Mario Alberto Barragán Espinosa on 10/09/22.
//

import XCTest
@testable import CoolFruits

final class FruitDetailSnapshotTests: XCTestCase {
    func test_detailView_AppleFruit() {
        let sut = makeSUT(with: FruitModel.makeAppleFruitModel())
        
        assert(sut, mode: .light, device: .iPhoneX)
        assert(sut, mode: .dark, device: .iPhoneX)
    }
    
    func test_detailView_lemonFruit() {
        let sut = makeSUT(with: FruitModel.makeLemonFruitModel())
        
        record(sut, mode: .light, device: .iPhoneX)
        record(sut, mode: .dark, device: .iPhoneX)
    }
    
    private func makeSUT(with fruit: FruitModel,
                         file: StaticString = #file,
                         line: UInt = #line) -> FruitDetailViewController {
        let sut = FruitDetailViewController(fruit: fruit)
        
        sut.loadViewIfNeeded()
        
        return sut
    }
}
