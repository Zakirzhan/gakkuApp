//
//  RadioViewController.swift
//  GakkuApp
//
//  Created by macbook on 02.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography


class TVViewController: UIViewController {
    var tvProgramms: [GakkuTVProgramms] = []
    let logoImage = UIImageView()
   
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow"), for: .normal)
        return button
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TVProgrammsCollectionViewCell.self, forCellWithReuseIdentifier: "tvProgramms")
        return collectionView
    }()
    
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
         layout.itemSize = CGSize(width:self.view.frame.width/2.5, height:self.view.frame.width/3)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.allowsInlineMediaPlayback = true
        webView.mediaPlaybackRequiresUserAction = false
         return webView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        loadYoutube()
        loadData()
    }
    func respondToSwipeGesture() {
        _ = navigationController?.popViewController(animated: true);
    }
    func configureViews(){
        navigationItem.hidesBackButton = true
        self.navigationController?.navigationItem.hidesBackButton = true
        [logoImage,rightButton,webView,collectionView].forEach {
            view.addSubview($0)
        }
        logoImage.image = UIImage(named:"LOGO")
        view.backgroundColor = UIColor(red:0.10, green:0.16, blue:0.25, alpha:1.0)
        rightButton.addTarget(self, action: #selector(self.respondToSwipeGesture), for: .touchUpInside)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func loadYoutube() { 
        let embedHTML = "<html><head><title>TV Online</title><meta name='viewport' content='initial-scale=1, user-scalable=no, width=device-width' /></head><body style='margin:0px;padding:0px;'><script type='text/javascript' src='https://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady() ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){ a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='100%' height='100%' src='https://www.youtube.com/embed/\(Constant.Settings.onlineTVId)?rel=0&amp;controls=0&amp;showinfo=0' frameborder='0'></body></html>"
        webView.loadHTMLString(embedHTML, baseURL: nil)
     }
    func loadData() {
        GakkuApi.getTVProgramms() { [unowned self] (array, error) in
            guard let newsList = array else {
                print("Error")
                return
            }
            self.tvProgramms = newsList
            self.collectionView.reloadData()
        }
    }
    
    func configureConstraints(){
        constrain(logoImage,webView, rightButton,collectionView, view) { li, wv, rb, cv, v in
            li.centerX == v.centerX
            li.top == v.top + 100
            li.width == v.width - 52
            li.height == v.width/3.6
            
            rb.centerY == v.centerY
            rb.left == v.left + 10
            
            wv.top == li.bottom + 20
            wv.left == rb.right + 10
            wv.width == v.width - 80
            wv.height == v.height/3
            
            cv.bottom == v.bottom - 20
            cv.left == v.left + 10
            cv.width == v.width - 20
            cv.height == v.height/3
             cv.centerX == v.centerX 
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
extension TVViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvProgramms.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tvProgramms", for: indexPath) as! TVProgrammsCollectionViewCell
        cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
        cell.titleLabel.text = tvProgramms[indexPath.row].name
        cell.dateLabel.text = tvProgramms[indexPath.row].date
        cell.descriptionLabel.text = tvProgramms[indexPath.row].about
         return cell
        
    }
}

