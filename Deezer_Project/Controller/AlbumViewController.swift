//
//  AlbumViewController.swift
//  Deezer_Project
//
//  Created by Mert Altay on 12.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

//private let reuseIdentifier = "AlbumCell"

protocol AlbumOutPut {
    func saveData(values: [Album])
}

class AlbumViewController: UIViewController {
    
    //MARK: - Properties
    let albumTableView = UITableView()
    let albumImageView = UIImageView()

    private var artistName: Artist
    var myArtistId: Int
    var myArtistPicture: String
    private var artistPicture: String?
    
    private lazy var albumResult: [Album] = []
    lazy var viewModel: IAlbumViewModel = AlbumViewModel()
    //MARK: - Lifecycle
    init(artistName: Artist) {
        self.artistName = artistName
        self.myArtistId = artistName.id
        self.myArtistPicture = artistName.picture_big
        Singleton.shared.artistId = myArtistId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        style()
        setImageView()
        setTableView()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()

    }
}
    //MARK: - Helpers
extension AlbumViewController {
    private func style(){
        self.navigationItem.title = artistName.name
        
    }
    
    private func setImageView() {
        albumImageView.customMode()
        view.addSubview(albumImageView)
        albumImageView.backgroundColor = .blue
        albumImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }

    private func setTableView() {
        albumTableView.delegate = self
        albumTableView.dataSource = self
        albumTableView.separatorStyle = .none
        albumTableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.identifier)
        view.addSubview(albumTableView)
        // 30 padding boşluk bırakacak imageviewdan
        albumTableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        // 30 padding aşağıdan scroll edilecek
        albumTableView.scrollIndicatorInsets = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        
        albumTableView.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    // görsel ve tableview un aynı anda gözükmesi için
    internal override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        albumTableView.frame = CGRect(x: 0, y: albumImageView.frame.maxY, width: view.bounds.width, height: view.bounds.height - albumImageView.frame.maxY)
        
    }
}
    //MARK: - UITableViewDataSource
extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell: AlbumTableViewCell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier,for: indexPath) as? AlbumTableViewCell else {
             
             return UITableViewCell()
         }
         cell.saveModel(model: albumResult[indexPath.row])
         return cell
        }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return albumResult.count
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConstantValues.AlbumTableViewHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albumResult[indexPath.item]
        let controller = SongViewController(albumName: album)
        self.navigationController?.pushViewController(controller, animated: true)
    }

    }

    //MARK: - Save Data

extension AlbumViewController: AlbumOutPut {
    func saveData(values: [Album]) {
        albumResult = values
        albumImageView.kf.setImage(with: URL(string: myArtistPicture))
        albumTableView.reloadData()
    }
    
}
