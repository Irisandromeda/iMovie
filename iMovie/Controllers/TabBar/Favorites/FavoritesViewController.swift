//
//  FavoritesViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import UIKit
import SDWebImage
import FirebaseFirestore

class FavoritesViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private let favoriteMovieId = "FavoriteMovieCell"
    
    private var moviesListener: ListenerRegistration?
    
    private var movies: [Movie] = []
    
    private var currentUser: UserModel
    
    init(user: UserModel) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        moviesListener?.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
        
        moviesListener = ListenerService.shared.moviesListener(movies: movies) { result in
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Выполнение действий для удаления ячейки
            
            // Удаление объекта из источника данных
            FireStoreService.shared.deleteMovie(movie: movies[indexPath.item]) { result in
                switch result {

                case .success(_):
                    print("Movie - removed")
                case .failure(let error):
                    self.showAlert(title: "Something was wrong!", message: error.localizedDescription)
                }
            }
            self.movies.remove(at: indexPath.item)
            
            // Удаление ячейки из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = MovieViewController(user: currentUser, movie: movies[indexPath.item])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
