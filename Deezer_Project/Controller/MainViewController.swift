//
//  MainViewController.swift
//  Deezer_Project
//
//  Created by Mert Altay on 10.05.2023.
//

import UIKit

private let reuseIdentifier = "MainCell"

protocol CategoriesOutPut {
    func saveData(values: [Category])
}
class MainViewController: UICollectionViewController {
    
    // MARK: - Properties
    lazy var categoryResult: [Category] = []
    
    lazy var viewModel: ICategoryViewModel = CategoryViewModel()
    // MARK: - Lifecycle
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    // MARK: - HELPERS

extension MainViewController{
    private func setup() {
        view.backgroundColor = .white
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
        
    }

}

    //MARK: - UICollectionViewDataSource
extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryResult.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.saveModel(model: categoryResult[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = self.categoryResult[indexPath.item]
        let controller = ArtistViewController(category: category)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    

}

    //MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
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

    //MARK: - Category save data extension

extension MainViewController: CategoriesOutPut {
    func saveData(values: [Category]) {
        categoryResult = values
        collectionView.reloadData()
    }
    
    
}
