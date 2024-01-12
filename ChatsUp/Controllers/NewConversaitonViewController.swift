//
//  NewConversaitonViewController.swift
//  ChatsUp
//
//  Created by Tahir Atakan Can on 13.11.2023.
//

import UIKit
import JGProgressHUD

class NewConversaitonViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private var users = [[String:String]]()
    private var hasFetched = false
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Users..."
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "No Results"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let blueGreenColor = UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
        view.backgroundColor = blueGreenColor
        
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dismissSelf))
        searchBar.becomeFirstResponder()
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
}


extension NewConversaitonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: " ").isEmpty else {
            return
        }
        
        spinner.show(in: view)
        
        self.searchUsers(query: text)
        
    }
    func searchUsers(query: String) {
        // check if array has firebase results
        if hasFetched{
            // if it does: filter
        }
        else {
            // if not, fetch then filter
        }
        // update the UI: eitehr show results or show no results label
        
        
    }
    
}
