//
//  FavoriteViewController.swift
//  Deezer_Project
//
//  Created by Mert Altay on 10.05.2023.
//

import UIKit
//private let reuseIdentifier = "FavoriteCell"

class FavoriteViewController: UITableViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}
    // MARK: - HELPERS

extension FavoriteViewController {
    private func style() {
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
    }
    private func layout() {
        
    }
}

    //MARK: - UITableViewDataSource

extension FavoriteViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FavoriteTableViewCell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        return cell
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ConstantValues.AlbumTableViewHeight
    }
    }


