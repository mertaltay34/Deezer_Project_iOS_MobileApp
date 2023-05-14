//
//  PlayerViewController.swift
//  Deezer_Project
//
//  Created by Mert Altay on 14.05.2023.
//

import UIKit
import SnapKit
import Kingfisher
import AVKit

class PlayerViewController: UIViewController {
    //MARK: - Properties
    var song: Song
    private var songPicture: String?
    private var songName: String?
    private var artistName: String?
    
    private var mainStackView: UIStackView!
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return button
    }()
    
    private let previewLabel : UILabel = {
        let label = UILabel()
        label.text = "Önizleme"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    private let songNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Song name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let artistNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Artist name"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .black
        return lineView
    }()
    
    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.customMode()
        imageView.backgroundColor = .systemPurple
        return imageView
    }()
    
    private let sliderView: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        return slider
    }()
    
    private let startLabel: UILabel = {
        let label = UILabel()
        label.text = "00 : 00"
        label.textAlignment = .left
        return label
    }()
    private let endLabel: UILabel = {
        let label = UILabel()
        label.text = "00 : 00"
        label.textAlignment = .right
        return label
    }()
    
    private var playStackView: UIStackView!
    
    private lazy var goForwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "goforward.5"), for: .normal)
        button.addTarget(self, action: #selector(handleGoForwardButton), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(handleGoPlayButton), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private lazy var goBackwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "gobackward.5"), for: .normal)
        button.addTarget(self, action: #selector(handlegoBackwardButton), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private lazy var volumeSliderView: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.addTarget(self, action: #selector(handlevolumeSliderView), for: .valueChanged)
        return slider
    }()
    private var volumeStackView: UIStackView!
    
    private let plusImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "speaker.wave.3.fill")
        imageView.tintColor = .lightGray
        return imageView
    }()
    private let minusImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "speaker.wave.1.fill")
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    private let player: AVPlayer = {
        let player = AVPlayer()
        
        return player
    }()
    
    //MARK: Lifecycle
    init(song: Song) {
        self.song = song
        self.songPicture = "https://e-cdns-images.dzcdn.net/images/cover/\(song.md5_image)/500x500.jpg"
        self.songName = song.title
        self.artistName = Singleton.shared.artistName
        super.init(nibName: nil, bundle: nil)
        style()
        layout()
        saveModel()
        startPlay()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.pause()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    //MARK: - Selectors
extension PlayerViewController {
    @objc private func handlevolumeSliderView(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    @objc private func handlegoBackwardButton() {
        updateForward(value: -5)
    }
    
    @objc private func handleGoForwardButton() {
        updateForward(value: 5)
    }
    @objc private func handleGoPlayButton() {
        if player.timeControlStatus == .paused {
            player.play()
            self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            player.pause()
            self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @objc private func handleCloseButton() {
        player.pause()
        self.dismiss(animated: true)
    }
}
    //MARK: - Helpers

extension PlayerViewController {
    private func updateForward(value: Int64){
        let exampleTime = CMTime(value: value, timescale: 1)
        let seekTime = CMTimeAdd(player.currentTime(), exampleTime)
        player.seek(to: seekTime)
    }
    
    fileprivate func updateSlider(){
        let currentTimeSecond = CMTimeGetSeconds(player.currentTime())
        let durationTime = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let resultSecondTime = currentTimeSecond / durationTime
        self.sliderView.value = Float(resultSecondTime)
    }
    
    fileprivate func updateTimeLabel() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            self.startLabel.text = time.formatString()
            let endTimeSecond = self.player.currentItem?.duration
            self.endLabel.text = endTimeSecond?.formatString()
            self.updateSlider()
        }
    }
    private func startPlay() {
        guard let url = URL(string: song.preview ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        self.volumeSliderView.value = 50
        updateTimeLabel()
    }
    
    private func style() {
        view.backgroundColor = .white
        
        playStackView = UIStackView(arrangedSubviews: [UIView(),goBackwardButton,UIView(),playButton,UIView(),goForwardButton,UIView()])
        playStackView.axis = .horizontal
        playStackView.distribution = .fillEqually
        
        volumeStackView = UIStackView(arrangedSubviews: [minusImageView,volumeSliderView,plusImageView])
        volumeStackView.axis = .horizontal
    }
    private func layout() {
        view.addSubview(closeButton)
        view.addSubview(songImageView)
        view.addSubview(previewLabel)
        view.addSubview(lineView)
        view.addSubview(songNameLabel)
        view.addSubview(artistNameLabel)
        view.addSubview(sliderView)
        view.addSubview(startLabel)
        view.addSubview(endLabel)
        view.addSubview(playStackView)
        view.addSubview(volumeStackView)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(40)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(previewLabel.snp.bottom).offset(10)
            make.height.equalTo(3)
            make.leading.trailing.equalToSuperview()
        }
        
        songImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.height.width.equalTo(120)
        }
        
        songNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(songImageView.snp.trailing).offset(20)
            make.top.equalTo(songImageView.snp.centerY).offset(-15)
            
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(songNameLabel.snp.leading)
            make.top.equalTo(songNameLabel.snp.bottom).offset(5)
            
        }
        sliderView.snp.makeConstraints { make in
            make.top.equalTo(songImageView.snp.bottom).offset(20)
            make.leading.equalTo(songImageView.snp.leading)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        startLabel.snp.makeConstraints { make in
            make.top.equalTo(sliderView.snp.bottom).offset(5)
            make.leading.equalTo(sliderView.snp.leading)
        }
        endLabel.snp.makeConstraints { make in
            make.top.equalTo(sliderView.snp.bottom).offset(5)
            make.trailing.equalTo(sliderView.snp.trailing)
        }
        playStackView.snp.makeConstraints { make in
            make.top.equalTo(startLabel.snp.bottom).offset(10)
            make.leading.equalTo(startLabel.snp.trailing).offset(50)
            make.height.equalTo(40)
        }
        volumeStackView.snp.makeConstraints { make in
            make.top.equalTo(playStackView.snp.bottom).offset(10)
            make.leading.equalTo(sliderView.snp.leading)
            make.trailing.equalTo(sliderView.snp.trailing)
        }
    }

}
    //MARK: - Save Data
extension PlayerViewController {
    func saveModel() {
        songImageView.kf.setImage(with: URL(string: songPicture ?? ""))
        songNameLabel.text = songName
        artistNameLabel.text = artistName
    }
}
