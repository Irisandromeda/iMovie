//
//  SearchViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import UIKit
import FirebaseAuth

class SearchViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    private let model = Model.shared
    
    private let searchMovieCellId = "searchMovieCellId"
    private let searchHeaderCellId = "searchHeaderCellId"
    
    private var currentUser: User
    
    init(user: User) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupSubviews()
    }
    
    private func setupSubviews() {
        searchTF.delegate = self
        setupSearchCollectionViewLayout()
    }
    
    private func setupNavigationBar() {
        title = "Search"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "labelColor")!]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "labelColor")!]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        searchCollectionView.collectionViewLayout = layout
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        searchCollectionView.register(UINib(nibName: "SearchMovieCell", bundle: nil), forCellWithReuseIdentifier: searchMovieCellId)
    }
}

//MARK: Collection View Data Source

extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchMovieCellId, for: indexPath) as? SearchMovieCell else { return UICollectionViewCell() }
        
        if !model.movies.isEmpty {
            cell.configureCell(movies: model.movies[indexPath.row])
        }
        
        return cell
    }
}

//MARK: Collection View Delegate

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = MovieViewController(user: currentUser, movie: model.movies[indexPath.item])
        present(viewController, animated: true)
    }
}

//MARK: Collection View Delegate Flow Layout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = Int(collectionView.bounds.width)
        let itemWidth = 165
        let itemHeight = 240
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    }
}

//MARK: Text Field Delegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        guard let text = textField.text else { return false }
        model.fetchMovies(movieName: text, collectionView: searchCollectionView)
        return false
    }
}
