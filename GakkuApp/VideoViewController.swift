//
//  VideoViewController.swift
//  GakkuApp
//
//  Created by macbook on 03.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

class VideoViewController: UIViewController {
    var video: YoutubeParser?
    var stat: [YoutubeVideo]?
 
    lazy var activityIndicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        return activityIndicator
    }()
    lazy var webView: UIWebView = {
        let web = UIWebView()
        web.delegate = self
        web.backgroundColor = .white
        return web
    }()
    let logoImage = UIImageView()
    let dislikeImage = UIImageView()
    let likeImage = UIImageView()
    let lineImage = UIImageView()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red:0.60, green:0.66, blue:0.72, alpha:1.0)
        label.numberOfLines = 10
        return label
    }()
    lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red:0.60, green:0.66, blue:0.72, alpha:1.0)
        return label
    }()
    lazy var dislikeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red:0.60, green:0.66, blue:0.72, alpha:1.0)
        return label
    }()
    lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = UIColor(red:0.40, green:0.46, blue:0.53, alpha:1.0)
        return label
    }()
    lazy var channelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = .gray
        return label
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        self.activityIndicator.startAnimating()
        constrains()
        self.loadData()
        loadYoutube(videoID: (video?.id)!)
        loadStatistic(videoID: (video?.id)!)
     }
    func loadData(){
        self.title = "Видео"
        self.titleLabel.text = (video?.title)!
        self.descriptionLabel.text = (video?.description)!
        self.channelName.text = "Gakku TV"
        self.lineImage.image = UIImage(named:"Line")
        self.dislikeImage.image = UIImage(named:"dislike")
        self.likeImage.image = UIImage(named:"like")
        let date = (video?.date)!.truncate(length: 10)
        self.viewsLabel.text = "0 views"
        self.likeLabel.text = "0"
        self.dislikeLabel.text = "0"
        self.dateLabel.text = date
        self.logoImage.image = UIImage(named:"logo2")

    }
    func loadStat(){
        self.viewsLabel.text = "\((stat?[0].viewCount)!) views"
        self.likeLabel.text = stat?[0].likeCount
        self.dislikeLabel.text = stat?[0].dislikeCount
    }
    func loadYoutube(videoID:String) {
        webView.backgroundColor = .white
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.allowsInlineMediaPlayback = true
        webView.mediaPlaybackRequiresUserAction = false
        let embedHTML = "<html><head><title>TV Online</title><meta name='viewport' content='initial-scale=1, user-scalable=no, width=device-width' /></head><body style='margin:0px;padding:0px;'><script type='text/javascript' src='https://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady() ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){ a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='100%' height='\(self.view.frame.height/3)' src='https://www.youtube.com/embed/\(videoID)?rel=0&amp;controls=0&amp;showinfo=0' frameborder='0'></body></html>"
        webView.loadHTMLString(embedHTML, baseURL: nil)
        
    }
    func loadStatistic(videoID: String){
        YoutubeParser.getVideo(id: videoID) { [unowned self] (array, error) in
            guard let youtubeVideo = array else {
                print("Error")
                return
            }
            self.stat = youtubeVideo
            self.loadStat()
        }
    }

    func configureViews(){
   [webView,activityIndicator,titleLabel,logoImage,dateLabel,channelName,viewsLabel,dislikeImage,likeImage,lineImage,dislikeLabel,likeLabel,descriptionLabel].forEach{
            view.addSubview($0)
        }
        self.view.backgroundColor = .white
        self.webView.backgroundColor = .white
    }
    
    func constrains(){
        constrain(webView, titleLabel, activityIndicator,view){ wv, tl, ai, v  in
            wv.top == v.top
            wv.left == v.left
            
            
            wv.width == v.width
            wv.height == v.height/2.5
            
            tl.top == wv.bottom + 10
            tl.left == v.left + 16
            tl.width == v.width - 32
            ai.center == wv.center
            
        }
        
        constrain(titleLabel, logoImage, channelName, dateLabel,viewsLabel){ tl, logo, cn, dl, vl   in
            logo.top == tl.bottom + 10
            logo.left == tl.left
            
            cn.top == tl.bottom + 10
            cn.left == logo.right + 10
            
            vl.top == tl.bottom + 10
            vl.right == tl.right
            
            
            dl.top == cn.bottom + 5
            dl.left == logo.right + 10
        }
        
        constrain(viewsLabel, lineImage, dislikeLabel,dislikeImage){ vl, line, dislbl,disimg   in
            line.top == vl.bottom + 5
            line.right == vl.right
            
            dislbl.top == line.bottom + 10
            dislbl.right == vl.right
            
            disimg.right == dislbl.left - 5
            disimg.top == dislbl.top
        }
        constrain(dislikeLabel,dislikeImage, likeLabel, likeImage, viewsLabel){ dislbl,disimg, likelbl, likeimg, vL in
            likeimg.left ==  vL.left
            likeimg.top == dislbl.top
            likelbl.left == likeimg.right + 5
            likelbl.top == dislbl.top
        }
        constrain(descriptionLabel, dislikeLabel, view){ desc, dis, v in
            desc.top == dis.bottom + 16
            desc.left == v.left + 16
            desc.width == v.width - 32
            
        }
    }
}

extension String {
    func truncate(length: Int) -> String {
        if self.characters.count > length {
            return String(self.characters.prefix(length))
        } else {
            return self
        }
    }
}

extension VideoViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
            self.webView.backgroundColor = .white
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
        
    }
}
