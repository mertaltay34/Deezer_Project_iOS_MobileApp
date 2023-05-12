//
//  ArtistViewController.swift
//  Deezer_Project
//
//  Created by Mert Altay on 11.05.2023.
//

import UIKit

private let reuseIdentifier = "ArtistCell"

protocol ArtistOutPut {
    func saveData(values: [Artist])
}

class ArtistViewController: UICollectionViewController {

    //MARK: - Properties
    private var category: Category
    private lazy var artistResult: [Artist] = []
    lazy var viewModel: IArtistViewModel = ArtistViewModel()
    
    var categoryId: Int
    //MARK: - Lifecycle
    
    init(category: Category) {
        let flowLayout = UICollectionViewFlowLayout()
//        super.init(nibName: nil, bundle: nil)
        self.category = category
        self.categoryId = category.id
        Singleton.shared.artistCategoryId = categoryId
        super.init(collectionViewLayout: flowLayout)
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    //MARK: - Helpers

extension ArtistViewController {
    
    private func setup() {
        self.navigationItem.title = category.name
        collectionView.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }

}

    //MARK: - UICollectionViewDataSource

extension ArtistViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artistResult.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ArtistCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ArtistCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.saveModel(model: artistResult[indexPath.row])

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var artistName = artistResult[indexPath.item]
        let controller = AlbumViewController(artistName: artistName )
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ArtistViewController: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width - 30) / 2
    return .init(width: width, height: width + 50)
    }
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
        }
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10
        }

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 10, left: 10, bottom: 10, right: 10)
        }
}

    //MARK: - Save Artist Data

extension ArtistViewController: ArtistOutPut {
    func saveData(values: [Artist]) {
        artistResult = values
        collectionView.reloadData()
    }
    
    
}
