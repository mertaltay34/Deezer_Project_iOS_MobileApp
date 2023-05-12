//
//  AlbumTableViewCell.swift
//  Deezer_Project
//
//  Created by Mert Altay on 12.05.2023.
//

import UIKit
import SnapKit

class AlbumTableViewCell: UITableViewCell {
    //MARK: - Properties

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
        backgroundColor = .red

    }
    
    private func layout() {
        
            }
    
}
