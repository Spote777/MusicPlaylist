//
//  MusicView.swift
//  MusicPlaylist
//
//  Created by Павел Заруцков on 18.01.2023.
//

import UIKit

class MusicView: UIView {
    
    // MARK: - Properties
    
    private(set) var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.separatorInset = .init(top: 0, left: 125, bottom: 0, right: 0)
        
        return tb
    }()
    
    private(set) var searchBar: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Искать в плейлистах"
        return search
    }()
    
    // MARK: - Life cycles
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupViews() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
