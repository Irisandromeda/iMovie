//
//  FavoritesViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Favorites"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "labelColor")!]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "labelColor")!]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
