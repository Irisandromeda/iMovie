//
//  ProfileViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!

    private let topCellId = "TopCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "TopCell", bundle: nil), forCellReuseIdentifier: topCellId)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNavigationBar() {
        title = "Profile"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "labelColor")!]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "labelColor")!]
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

//MARK: Table View Data Source

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: topCellId) as? TopCell else { return UITableViewCell() }
            
            cell.contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: Table View Delegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {

        case 0:
            return CGFloat(200)

        default:
            return CGFloat(200)
        }
    }
}
