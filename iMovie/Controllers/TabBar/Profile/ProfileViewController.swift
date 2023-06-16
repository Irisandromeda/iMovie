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
    private let bottomCellId = "BottomCell"
    
    private var currentUser: UserModel
    
    init(user: UserModel) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "TopCell", bundle: nil), forCellReuseIdentifier: topCellId)
        tableView.register(UINib(nibName: "BottomCell", bundle: nil), forCellReuseIdentifier: bottomCellId)
        
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: topCellId) as? TopCell else { return UITableViewCell() }
            
            cell.name.text = currentUser.username
            cell.email.text = currentUser.email
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: bottomCellId) as? BottomCell else { return UITableViewCell() }
            
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
        case 1:
            return CGFloat(55)
        default:
            return 0
        }
    }
}
