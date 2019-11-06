//
//  ViewController.swift
//  beelding
//
//  Created by AdrienGreiner on 16/10/2019.
//  Copyright © 2019 Beeldi. All rights reserved.
//

import UIKit

final class EquipmentListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = EquipmentListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        viewModel.loadOrderedEquipmentsList { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                // Popup or banner can display this kind of error
                print("Error: Une erreur est survenue.")
            }
        }
    }
}

// MARK: - TableView Setup

fileprivate extension EquipmentListViewController {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let equipmentCellNib = UINib(nibName: String(describing: EquipmentTableViewCell.self), bundle: nil)
        tableView.register(equipmentCellNib, forCellReuseIdentifier: EquipmentTableViewCell.identifier)
    }
}

// MARK: - TableView Data Source

extension EquipmentListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return EquipmentListViewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowIn(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EquipmentTableViewCell.identifier) as? EquipmentTableViewCell else {
            fatalError("Error Dequeue Reusable Cell. Identifier is probably bad.")
        }
        cell.fill(with: viewModel.equipmentAt(indexPath))
        return cell
    }
}

// MARK: - TableView Delegate

extension EquipmentListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsViewController = EquipmentDetailsViewController(nibName: String(describing: EquipmentDetailsViewController.self), bundle: nil)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
