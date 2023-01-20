//
//  SongTableViewCell.swift
//  MusicPlaylist
//
//  Created by Павел Заруцков on 18.01.2023.
//

import UIKit
import Kingfisher

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "cell"
    
    private(set) var songImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private(set) var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    private(set) var titleSong: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private(set) var subtitleSong: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Life cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        setupViews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        addSubview(contentView)
        contentView.addSubview(songImage)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleSong)
        stackView.addArrangedSubview(subtitleSong)
        
        NSLayoutConstraint.activate([
            songImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11),
            songImage.heightAnchor.constraint(equalToConstant: 100),
            songImage.widthAnchor.constraint(equalToConstant: 100),
            songImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            songImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            
            stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 11),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -11),
            stackView.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: 11)
        ])
    }
    
    // MARK: - Configure cell
    
    func configureCell(model: Album) {
        titleSong.text = model.title
        subtitleSong.text = model.subtitle
        downloadImage(imagePath: model.image, imageView: songImage)
    }
}

// MARK: - Private function

extension SongTableViewCell {
    private func downloadImage(imagePath: String?, imageView: UIImageView) {
        if let imageString = imagePath {
            guard let urlImage = URL(string: imageString) else {
                return
            }
            let cache = ImageCache.default
            if cache.isCached(forKey: imageString) {
                cache.retrieveImage(forKey: imageString) { result in
                    switch result {
                    case .success(let value):
                        imageView.kf.indicatorType = .activity
                        DispatchQueue.main.async {
                            imageView.image = value.image
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            } else {
                let resource = ImageResource(downloadURL: urlImage, cacheKey: imageString)
                imageView.kf.indicatorType = .activity
                DispatchQueue.main.async {
                    imageView.kf.setImage(with: resource)
                }
            }
        }
    }
}
