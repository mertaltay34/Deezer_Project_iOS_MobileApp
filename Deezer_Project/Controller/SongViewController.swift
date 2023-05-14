//
//  SongViewController.swift
//  Deezer_Project
//
//  Created by Mert Altay on 14.05.2023.
//

import UIKit

protocol SongOutPut {
    func saveData(values: [Song])
}

class SongViewController: UITableViewController {
    //MARK: - Properties
    
    private var albumName: Album
    var myAlbumId: Int
    private lazy var songResult: [Song] = []
    lazy var viewModel: ISongViewModel = SongViewModel()
    //MARK: - Lifecycle
    init(albumName: Album) {
        self.albumName = albumName
        self.myAlbumId = albumName.id
        Singleton.shared.albumId = myAlbumId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        style()
        layout()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
}
    //MARK: - Helpers

extension SongViewController {
    private func style() {
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.identifier)
        self.navigationItem.title = albumName.title
    }
    private func layout() {
        
    }
}

    //MARK: - UITableViewDataSource

extension SongViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songResult.count
        }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SongTableViewCell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath) as? SongTableViewCell else {
            return UITableViewCell()
        }
        cell.saveModel(model: songResult[indexPath.row])
        return cell
        }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ConstantValues.AlbumTableViewHeight
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = self.songResult[indexPath.item]
        let controller = PlayerViewController(song: song)
        controller.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.25)
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(controller, animated: true)
    }

    }
    //MARK: - Save Data
extension SongViewController: SongOutPut {
    func saveData(values: [Song]) {
        songResult = values
        tableView.reloadData()
    }

}
