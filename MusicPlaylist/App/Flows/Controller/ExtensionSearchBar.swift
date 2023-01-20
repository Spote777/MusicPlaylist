//
//  ExtensionSearchBar.swift
//  MusicPlaylist
//
//  Created by Павел Заруцков on 19.01.2023.
//

import UIKit

extension MusicViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filteredMusic = musicModel.filter({ $0.title.lowercased().contains(text.lowercased())})
        musicView.tableView.reloadData()
    }
}
