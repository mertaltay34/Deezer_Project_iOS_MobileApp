//
//  ArtistCollectionViewCell.swift
//  Deezer_Project
//
//  Created by Mert Altay on 11.05.2023.
//

import UIKit
import SnapKit

class ArtistCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    
    private let artistImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.customMode()
        imageView.backgroundColor = .systemPurple
        return imageView
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = . black
        return label
    }()
    
    private var fullStackView: UIStackView!
    //MARK: - Lifecyle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    //MARK: - Helpers

extension ArtistCollectionViewCell {
    private func style() {
        artistImageView.layer.cornerRadius = 12
        
        fullStackView = UIStackView(arrangedSubviews: [artistImageView,artistNameLabel])
        fullStackView.axis = .vertical

    }
    
    private func layout() {
        addSubview(fullStackView)
        
        artistImageView.snp.makeConstraints { make in
            make.height.equalTo(artistImageView.snp.width)
            }
            
        fullStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            }
        }
    }

//MARK: SaveData

extension ArtistCollectionViewCell {
func saveModel(model: Artist) {
    artistImageView.kf.setImage(with: URL(string: model.picture))
    artistNameLabel.text = model.name
}
}
