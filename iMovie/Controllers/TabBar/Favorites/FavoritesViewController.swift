//
//  FavoritesViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import UIKit
import SDWebImage

class FavoritesViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private let favoriteMovieId = "FavoriteMovieCell"
    
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
        
        FireStoreService.shared.getFavoriteMovies { result in
            switch result {
                
            case .success(let movies):
                self.movies = movies
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(title: "Something was wrong!", message: error.localizedDescription)
            }
        }
    }
    
    private func setupNavigationBar() {
        title = "Favorites"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "labelColor")!]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "labelColor")!]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "FavoriteMovieCell", bundle: nil), forCellReuseIdentifier: favoriteMovieId)
    }
}

//MARK: Table View Data Source

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favoriteMovieId, for: indexPath) as? FavoriteMovieCell else { return UITableViewCell() }
        
        if !movies.isEmpty {
            cell.configureCell(movie: movies[indexPath.row])
        }
            
        return cell
    }
}

//MARK: Table View Delegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
