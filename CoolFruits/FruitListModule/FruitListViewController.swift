//
//  FruitListViewController.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 12-07-22.
//

import UIKit

final class FruitListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var fruits = [FruitModel]()
    @IBOutlet weak var fruitsTableView: UITableView!
    
    var fruitsLoader: FruitsLoader?
    var selection: ((FruitModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigation()
        loadFruits()
    }
    
    private func configureTableView() {
        self.fruitsTableView.register(UINib.init(nibName: "FruitCell", bundle: nil), forCellReuseIdentifier: "FruitCell")
        self.fruitsTableView.delegate = self
        self.fruitsTableView.dataSource = self
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Fruitspedia"
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    private func loadFruits() {
        fruitsLoader?.getAllFruits({ [weak self] result in
            switch result {
            case .success(let fruits):
                self?.display(fruits)
                
            case .failure(let error):
                //TODO: handle error
                print(error)
            }
        })
    }
    
    func display(_ fruits: ([FruitModel])) {
        self.fruits = fruits
        self.fruitsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FruitCell") as? FruitCell else {
            return UITableViewCell()
        }
        let fruit = fruits[indexPath.row]
        
        cell.setUp(fruitName: fruit.name, 
                   fruitSugar: fruit.nutritions?.sugar ?? 0, 
                   isCitrus: fruit.isCitrus)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fruit = fruits[indexPath.row]
        selection?(fruit)
    }
}
