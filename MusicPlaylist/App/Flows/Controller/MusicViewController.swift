//
//  MusicViewController.swift
//  MusicPlaylist
//
//  Created by Павел Заруцков on 18.01.2023.
//

import UIKit

class MusicViewController: UITableViewController, UITextViewDelegate {
    
    // MARK: - Properties
    
    let musicView = MusicView()
    var musicModel: [Album] = []
    var filteredMusic: [Album] = []
    var isFiltering: Bool {
        return musicView.searchBar.isActive && !isSearchBarEmpty
    }
    var isSearchBarEmpty: Bool {
        return musicView.searchBar.searchBar.text?.isEmpty ?? true
    }
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setSearchController()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Плейлист"
        
    }
    
    override func loadView() {
        super.loadView()
        view = musicView
    }
}

// MARK: - Private function

extension MusicViewController {
    private func fetchData() {
        APIClient.getSong { [weak self] item in
            switch item {
            case .success(let item):
                self?.musicModel = item.albums
                self?.musicView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setTableView() {
        musicView.tableView.delegate = self
        musicView.tableView.dataSource = self
        musicView.tableView.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.reuseIdentifier)
    }
    
    private func setSearchController() {
        musicView.searchBar.searchResultsUpdater = self
        navigationItem.searchController =  musicView.searchBar
        definesPresentationContext = true
    }
}
