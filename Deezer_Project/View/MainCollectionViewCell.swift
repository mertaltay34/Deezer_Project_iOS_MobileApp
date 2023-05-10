//
//  MainCollectionViewCell.swift
//  Deezer_Project
//
//  Created by Mert Altay on 10.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    private let categoryImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.customMode()
        imageView.backgroundColor = .systemPurple
        return imageView
    }()
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = . black
        return label
    }()
    private var fullStackView: UIStackView!
    //MARK: - Lifecycle
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
extension MainCollectionViewCell {
    private func style() {
        categoryImageView.layer.cornerRadius = 12
        
        fullStackView = UIStackView(arrangedSubviews: [categoryImageView,categoryNameLabel])
        fullStackView.axis = .vertical
    }
    
    private func layout() {
        addSubview(fullStackView)
        
        categoryImageView.snp.makeConstraints { make in
            make.height.equalTo(categoryImageView.snp.width)
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

extension MainCollectionViewCell {
    func saveModel(model: Category) {
        categoryImageView.kf.setImage(with: URL(string: model.picture))
        categoryNameLabel.text = model.name
    }
}
