//
//  FruitListViewController.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 12-07-22.
//

import UIKit

final class FruitListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fruits = [FruitModel]()
    @IBOutlet weak var fruitsTableView: UITableView!
    
    var fruitsLoader: FruitsLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Fruitspedia"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        loadFruits()
    }
    
    private func configureTableView() {
        self.fruitsTableView.register(UINib.init(nibName: "CounterCellView", bundle: nil), forCellReuseIdentifier: "counterCell")
        self.fruitsTableView.delegate = self
        self.fruitsTableView.dataSource = self
    }
    
    private func loadFruits() {
        fruitsLoader?.getAllFruits({ result in
            switch result {
            case .success(let fruits):
                self.fruits = fruits
                self.fruitsTableView.reloadData()
                
            case .failure(let error):
                //TODO: handle error
                print(error)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "FruitCell") as? FruitCell
        
        if cell == nil {
            cell = FruitCell.createCell()
        }
        cell!.setUp(fruitName: fruits[indexPath.row].name, fruitSugar: fruits[indexPath.row].nutritions?.sugar, isCitrus: fruits[indexPath.row].genus == "Citrus")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fruit = fruits[indexPath.row]
        navigateToDetail(fruit: fruit)
    }
    
    func navigateToDetail(fruit: FruitModel) {
        let vc = FruitDetailViewController(fruit: fruit)
        vc.title = fruit.name
        if let navigator = navigationController {
            navigator.pushViewController(vc, animated: true)
        }
    }
}
