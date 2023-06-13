//
//  SearchViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    private let searchMovieCellId = "searchMovieCellId"
    
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchMovieCellId, for: indexPath) as? SearchMovieCell else { return UICollectionViewCell() }
        
        return cell
    }
}

//MARK: Collection View Delegate

extension SearchViewController: UICollectionViewDelegate {
    
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
        Model.shared.fetchMovies(movieName: text)
        return false
    }
}
