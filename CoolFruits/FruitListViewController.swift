//
//  FruitListViewController.swift
//  CoolFruits
//
//  Created by Luis Alejandro Zapata Gonzalez on 12-07-22.
//

import UIKit

public class HomeViewModel {
    var fruits: [FruitModel?]?
}

final class FruitListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel: HomeViewModel = HomeViewModel()
    @IBOutlet weak var fruitsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Fruitspedia"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        RequestManager.shared.getAllFruits { fruits, error in
            self.viewModel.fruits = fruits
            DispatchQueue.main.async {
                self.fruitsTableView.reloadData()
            }
        }
    }
    
    private func configureTableView() {
        self.fruitsTableView.register(UINib.init(nibName: "CounterCellView", bundle: nil), forCellReuseIdentifier: "counterCell")
        self.fruitsTableView.delegate = self
        self.fruitsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fruits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "FruitCell") as? FruitCell
        
        if cell == nil {
            cell = FruitCell.createCell()
        }
        cell!.setUp(fruitName: viewModel.fruits?[indexPath.row]?.name, fruitSugar: viewModel.fruits?[indexPath.row]?.nutritions?.sugar, isCitrus: viewModel.fruits?[indexPath.row]?.genus == "Citrus")
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SelectedFruit.fruit = viewModel.fruits?[indexPath.row]
        if SelectedFruit.fruit?.genus == "Citrus" {
            navigateToCitrusDetail()
        } else {
            navigateToDetail()
        }
    }
    var selectedFruit: FruitModel?
    
    func navigateToCitrusDetail() {
        let vc = FruitDetailViewController(fruit: SelectedFruit.fruit!)
        vc.title = SelectedFruit.fruit?.name
        if let navigator = navigationController {
            navigator.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToDetail() {
        let vc = FruitDetailViewController(fruit: SelectedFruit.fruit!)
        vc.title = SelectedFruit.fruit?.name
        if let navigator = navigationController {
            navigator.pushViewController(vc, animated: true)
        }
    }
}
