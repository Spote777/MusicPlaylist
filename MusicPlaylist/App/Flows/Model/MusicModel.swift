//
//  MusicModel.swift
//  MusicPlaylist
//
//  Created by Павел Заруцков on 18.01.2023.
//

import Foundation

// MARK: - MusicModel
struct MusicModel: Codable {
    let albums: [Album]
}

// MARK: - Album
struct Album: Codable {
    var title, subtitle: String
    let image: String
}
