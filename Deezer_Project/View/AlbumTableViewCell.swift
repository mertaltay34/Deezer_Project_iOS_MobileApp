//
//  AlbumTableViewCell.swift
//  Deezer_Project
//
//  Created by Mert Altay on 12.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

class AlbumTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "AlbumCell"
        
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let albumImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.customMode()
        imageView.backgroundColor = .systemPurple
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Album Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.textColor = . black
        return label
    }()
    
    private let albumReleaseDate: UILabel = {
        let label = UILabel()
        label.text = "Album Release Date"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    private let lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .black
        return lineView
    }()

    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    //MARK: - Helpers
extension AlbumTableViewCell {
    private func setup() {
        backgroundColor = .white
        addSubview(containerView)
        containerView.addSubview(albumImageView)
        containerView.addSubview(albumNameLabel)
        containerView.addSubview(lineView)
        containerView.addSubview(albumReleaseDate)

    }
    
    private func layout() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
        
        albumImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(2)
            make.leading.equalTo(containerView.snp.leading).offset(2)
            make.width.equalTo(85)
            make.bottom.equalTo(containerView.snp.bottom).offset(-2)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.equalTo(albumImageView.snp.trailing)
            make.height.equalTo(75)
            make.width.equalTo(2)
        }
        
        albumNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(lineView.snp.trailing).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).offset(-5)
            make.centerY.equalToSuperview().offset(-5)
        }
        
        albumReleaseDate.snp.makeConstraints { make in
            make.top.equalTo(albumNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(albumNameLabel.snp.leading)
        }
        
    }

}

    //MARK: - Save data

extension AlbumTableViewCell {
    func saveModel(model: Album){
        albumImageView.kf.setImage(with: URL(string: model.cover_medium))
        albumNameLabel.text = model.title
        albumReleaseDate.text = model.release_date
    }
    
}
