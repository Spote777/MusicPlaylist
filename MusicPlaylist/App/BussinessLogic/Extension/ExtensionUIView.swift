//
//  ExtensionUIView.swift
//  MusicPlaylist
//
//  Created by Павел Заруцков on 18.01.2023.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
