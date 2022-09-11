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
        assertThat(sut, isRendering: [])
        
        loader.completeFruitsLoading(with: [fruit0, fruit1], at: 0)
        assertThat(sut, isRendering: [fruit0, fruit1])
    }
    
    func test_fruitSelection_notifiesHandler() {
        let fruit0 = FruitModel.makeAppleFruitModel()
        let fruit1 = FruitModel.makeLemonFruitModel()
        var selectedFruits = [FruitModel]()
        let (sut, loader) = makeSUT(selection: { selectedFruits.append($0) })
        
        sut.loadViewIfNeeded()
        loader.completeFruitsLoading(with: [fruit0, fruit1], at: 0)

        sut.simulateTapOnFruit(at: 0)
        XCTAssertEqual(selectedFruits, [fruit0])
        
        sut.simulateTapOnFruit(at: 1)
        XCTAssertEqual(selectedFruits, [fruit0, fruit1])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(selection: @escaping (FruitModel) -> Void = { _ in },
                         file: StaticString = #file, 
                         line: UInt = #line) -> (sut: FruitListViewController,
                                                 loader: FruitsLoaderSpy) {
        let loader = FruitsLoaderSpy()
        let sut = FruitListComposer.composeWith(loader: loader,
                                                selection: selection)
        
        sut.fruitsLoader = loader
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(loader, file: file, line: line)
        
        return (sut, loader)
    }
    
    func assertThat(_ sut: FruitListViewController, 
                    isRendering fruits: [FruitModel], 
                    file: StaticString = #file, 
                    line: UInt = #line) {
        
        guard sut.numberOfRenderedFruits() == fruits.count else {
            return XCTFail("Expected \(fruits.count) fruits, got \(sut.numberOfRenderedFruits()) instead.", file: file, line: line)
        }

        fruits.enumerated().forEach { index, fruit in
            assertThat(sut, hasViewConfiguredFor: fruit, 
                       at: index, 
                       file: file, 
                       line: line)
        }        
    }
    
    func assertThat(_ sut: FruitListViewController, 
                    hasViewConfiguredFor fruit: FruitModel, 
                    at index: Int, 
                    file: StaticString = #file, 
                    line: UInt = #line) {
        let view = sut.feedFruitCell(at: index)

        guard let cell = view as? FruitCell else {
            return XCTFail("Expected \(FruitCell.self) instance, got \(String(describing: view)) instead", file: file, line: line)
        }
        let isCitrus = fruit.genus == "Citrus"
        let showedFruitText = "\(isCitrus ? " * " : "") \(fruit.name )"
        
        XCTAssertEqual(cell.fruitNameLabel.text!, showedFruitText, "Expected fruit name text to be \(String(describing: showedFruitText)) for  view at index (\(index))", file: file, line: line)
        
        let sugarValueString = "\((fruit.nutritions!.sugar!))"
        let showedSugarText = "(Sugar:" + String(sugarValueString) + ")"
        
        XCTAssertEqual(cell.fruitSugarLabel.text!, showedSugarText, "Expected fruit sugar text to be \(showedSugarText) for  view at index (\(index))", file: file, line: line)
    }
}

extension FruitListViewController {
    func numberOfRenderedFruits() -> Int {
        return fruitsTableView.numberOfRows(inSection: 0)
    }
    
    func feedFruitCell(at row: Int) -> UITableViewCell? {
        guard numberOfRenderedFruits() > row else {
            return nil
        }
        let ds = fruitsTableView.dataSource
        let index = IndexPath(row: row, section: 0)
        return ds?.tableView(fruitsTableView, cellForRowAt: index)
    }
    
    func simulateTapOnFruit(at row: Int) {
        let delegate = fruitsTableView.delegate
        let index = IndexPath(row: row, section: 0)
        delegate?.tableView?(fruitsTableView, didSelectRowAt: index)
    }
}
