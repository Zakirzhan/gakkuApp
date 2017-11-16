//
//  RadioViewController.swift
//  GakkuApp
//
//  Created by macbook on 02.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import AVFoundation 
import MediaPlayer

class RadioViewController: UIViewController, AVAudioPlayerDelegate {
    var number = 1
    var playRadio = false
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    
      lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RadioTableViewCell.self, forCellReuseIdentifier: "radioCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red:0.10, green:0.16, blue:0.25, alpha:1.0)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    lazy var volumeSlider: UISlider = {
        let volumeSlider = UISlider()
        volumeSlider.minimumValue = 0
        volumeSlider.setThumbImage(#imageLiteral(resourceName: "nowplaying"), for: .normal)
        volumeSlider.maximumValue = 100
        volumeSlider.isContinuous = true
        volumeSlider.addTarget(self, action: #selector(self.volumeSliderValueChanged(_:)), for: .valueChanged)
        volumeSlider.maximumTrackTintColor = UIColor(white: 0, alpha: 0.1)
        volumeSlider.minimumTrackTintColor = .white
        return volumeSlider
    }()
    
    let logoImage = UIImageView()
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
        return button
    }()
    
    lazy var radioButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "radioPlay"), for: .normal)
        button.addTarget(self, action:#selector(controlRadio), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.barStyle = .black
         configureViews()
        configureConstraints()
        playPlay()
        swipeToRadio()
    }
    func playPlay(){
        let url = URL(string: Constant.Settings.onlineStreamRadio)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem) 
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)
         let image:UIImage = UIImage(named: "logo2")!
        let artwork = MPMediaItemArtwork.init(boundsSize: image.size, requestHandler: { (size) -> UIImage in
            return image
        })
        MPNowPlayingInfoCenter.default().nowPlayingInfo
            = [
                MPMediaItemPropertyTitle : "Radio",
                MPMediaItemPropertyArtist : "Gakku",
                MPMediaItemPropertyArtwork : artwork
        ]
         becomeFirstResponder()
     }
    func volumeSliderValueChanged(_ volume:UISlider)
    {
        player?.volume = volume.value/100
        
    }
    override func remoteControlReceived(with event: UIEvent?) {
        if let event = event {
            if event.type == .remoteControl {
                switch event.subtype {
                case .remoteControlPlay:
                    player?.play()
                case .remoteControlPause:
                    player?.pause()
                default:
                    print("Def")
                }
            }
        }
    }
    func respondToSwipeGesture() {
        goToRightVC()
    }
    
    func configureViews(){
        [logoImage,leftButton,radioButton,volumeSlider].forEach{
            view.addSubview($0)
        }
        logoImage.image = UIImage(named:"LOGO")
        view.backgroundColor = UIColor(red:0.10, green:0.16, blue:0.25, alpha:1.0)
        self.volumeSlider.setValue(70, animated: true)
    }
    
    func goToRightVC() {
        let vc = TVViewController()
         navigationController?.pushViewController(vc, animated: true)
    }
 
    func controlRadio() {
        if !playRadio {
            player!.play()
            self.radioButton.setImage(#imageLiteral(resourceName: "radioPause"), for: .normal)
        }
        else {
            player!.pause()
            self.radioButton.setImage(#imageLiteral(resourceName: "radioPlay"), for: .normal)
        }
        playRadio = !playRadio
    }
    func configureConstraints(){
        constrain(logoImage, radioButton, leftButton, view) { li, ri, lb, v in
            li.centerX == v.centerX
            li.top == v.top + 100
            li.width == v.width - 52
            li.height == v.width/3.6
            
            ri.center == v.center
            
            lb.centerY == v.centerY
            lb.right == v.right - 10
            
        }
        constrain(radioButton, volumeSlider, tableView, view) { rb, vsc, tv, v in
          
            vsc.top == rb.bottom + 100
            vsc.width == 320
            vsc.height == 20
            vsc.left == v.left + 20
        }
    }
    func swipeToRadio(){
        leftButton.addTarget(self, action: #selector(self.respondToSwipeGesture), for: .touchUpInside)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension RadioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "radioCell", for: indexPath) as! RadioTableViewCell
        cell.titleLabel.text = "Track"
        cell.titleLabel.textColor = .white
        cell.durationLabel.text = "03:27"
        cell.selectionStyle = .none
        if number == 2 {
            cell.titleLabel.textColor = .white
            cell.durationLabel.textColor = .white
            cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
            cell.nowPlaying.image = UIImage(named: "nowplaying")
        }
        else{
            cell.titleLabel.textColor = .gray
            cell.durationLabel.textColor = .gray
            cell.favIcon.alpha = 0.5
         cell.backgroundColor = UIColor(white: 1, alpha: 0.01)
        }
        number += 1

        return cell
    }
}
