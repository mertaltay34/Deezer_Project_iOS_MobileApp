//
//  FavoriteTableViewCell.swift
//  Deezer_Project
//
//  Created by Mert Altay on 14.05.2023.
//

import UIKit
import SnapKit

class FavoriteTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "FavoriteCell"
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 8
        return view
    }()

    private let songImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.customMode()
        imageView.backgroundColor = .systemPurple
        return imageView
    }()

    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Song Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = . black
        return label
    }()

    private let songDuration: UILabel = {
        let label = UILabel()
        label.text = "Song Duration"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()

    private let lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .black
        return lineView
    }()
    private var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "heart"), for: .normal)
//        button.addTarget(self, action: #selector(handlefavoriteButton), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
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

    //MARK: - Selectors
extension FavoriteTableViewCell {
    @objc private func handlefavoriteButton() {
        
    }
}
    //MARK: - Helpers
extension FavoriteTableViewCell {
    private func setup() {
        backgroundColor = .white
        addSubview(containerView)
        containerView.addSubview(songImageView)
        containerView.addSubview(songNameLabel)
        containerView.addSubview(lineView)
        containerView.addSubview(songDuration)
        containerView.addSubview(favoriteButton)
    }
    private func layout() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }

        songImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(2)
            make.leading.equalTo(containerView.snp.leading).offset(2)
            make.width.equalTo(85)
            make.bottom.equalTo(containerView.snp.bottom).offset(-2)
        }

        lineView.snp.makeConstraints { make in
            make.leading.equalTo(songImageView.snp.trailing)
            make.height.equalTo(75)
            make.width.equalTo(2)
        }
        songNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(lineView.snp.trailing).offset(20)
            make.centerY.equalToSuperview().offset(-5)
        }

        songDuration.snp.makeConstraints { make in
            make.top.equalTo(songNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(songNameLabel.snp.leading)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
