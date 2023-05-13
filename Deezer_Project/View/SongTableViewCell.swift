//
//  SongTableViewCell.swift
//  Deezer_Project
//
//  Created by Mert Altay on 13.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

class SongTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "SongCell"

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
extension SongTableViewCell {
    private func setup() {
        backgroundColor = .white
        addSubview(containerView)
        containerView.addSubview(songImageView)
        containerView.addSubview(songNameLabel)
        containerView.addSubview(lineView)
        containerView.addSubview(songDuration)

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

    }

}

    //MARK: - Save data

extension SongTableViewCell {
    func saveModel(model: Song){
        let url = "https://e-cdns-images.dzcdn.net/images/cover/\(model.md5_image)/500x500.jpg"
        songImageView.kf.setImage(with: URL(string: url))
        songNameLabel.text = model.title
//        albumReleaseDate.text = "123"
    }

}
