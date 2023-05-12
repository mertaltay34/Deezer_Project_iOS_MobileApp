//
//  AlbumViewController.swift
//  Deezer_Project
//
//  Created by Mert Altay on 12.05.2023.
//

import UIKit
import SnapKit

private let reuseIdentifier = "AlbumCell"

class AlbumViewController: UIViewController {
    //MARK: - Properties
    let tableView = UITableView()
    let imageView = UIImageView()

    private var artistName: Artist
    //MARK: - Lifecycle
    init(artistName: Artist) {
        self.artistName = artistName
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

    }
}
    //MARK: - Helpers
extension AlbumViewController {
    private func style(){
        self.navigationItem.title = artistName.name
        
    }
    
    private func setImageView() {
        imageView.customMode()
        view.addSubview(imageView)
        imageView.backgroundColor = .blue
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = .red
        view.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        
    }

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        // 30 padding boşluk bırakacak imageviewdan
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        // 30 padding aşağıdan scroll edilecek
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: imageView.frame.maxY, width: view.bounds.width, height: view.bounds.height - imageView.frame.maxY)
        
    }
}



    //MARK: - UITableViewDataSource
extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,for: indexPath)
        cell.backgroundColor = .systemGray
        return cell
        }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        }


    }

