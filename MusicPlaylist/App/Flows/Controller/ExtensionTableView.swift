//
//  ExtensionMusicViewController.swift
//  MusicPlaylist
//
//  Created by Павел Заруцков on 18.01.2023.
//

import UIKit
import Kingfisher

extension MusicViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMusic.count
        }
        return musicModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.reuseIdentifier, for: indexPath) as? SongTableViewCell else {return UITableViewCell()}
        let item: Album
        if isFiltering {
            item = filteredMusic[indexPath.row]
        } else {
            item = musicModel[indexPath.row]
        }
        cell.configureCell(model: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        var item: Album
        if isFiltering {
            item = filteredMusic[indexPath.row]
        } else {
            item = musicModel[indexPath.row]
        }
        
        return UIContextMenuConfiguration(identifier: indexPath as NSIndexPath, previewProvider: nil) { _ in
            
            let rename = UIAction(title: "Переименовать", image: UIImage(systemName: "square.and.pencil")) { action in
                let alert = UIAlertController(title: "Переименовать название песни?",message: "",preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { (alertAction: UIAlertAction!) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                alert.addTextField { (textField) in
                    textField.text = "\(item.title)"
                }
                
                alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {
                    (alertAction: UIAlertAction) in
                    guard let text = alert.textFields?[0].text else {return}
                    self.updateAlbumTitle(imageUrl: item.image, newTitle: text, tableView: tableView)
                }))
                alert.view.layer.cornerRadius = 25
                self.present(alert, animated: true, completion: nil)
            }
            
            let delete = UIAction(title: "Скрыть", image: UIImage(systemName: "eye.slash")) { action in
                self.deleteRow(tableView: tableView, indexPath: indexPath)
            }
            return UIMenu(title: "", children: [rename, delete])
        }
    }
}

// MARK: - Private function

extension MusicViewController {
    
    func updateAlbumTitle(imageUrl: String, newTitle: String?, tableView: UITableView) {
        let index = musicModel.firstIndex{ $0.image == imageUrl }
        let filterIndex = filteredMusic.firstIndex { $0.image == imageUrl }
        if isFiltering {
            guard let index = filterIndex else { return }
            if newTitle != nil && newTitle?.trimmingCharacters(in: .whitespaces) != "" {
                filteredMusic[index].title = newTitle ?? ""
                print(filteredMusic[index].title)
                tableView.reloadData()
            }
        } else {
            guard let index = index else { return }
            if newTitle != nil && newTitle?.trimmingCharacters(in: .whitespaces) != "" {
                musicModel[index].title = newTitle ?? ""
                tableView.reloadData()
            }
        }
    }
    
    private func deleteRow(tableView: UITableView, indexPath: IndexPath) {
        if self.isFiltering {
            tableView.beginUpdates()
            self.filteredMusic.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        } else {
            tableView.beginUpdates()
            self.musicModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

