//
//  ProfileViewController.swift
//  GakkuApp
//
//  Created by macbook on 02.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

class AboutViewController: UIViewController {
    public lazy var bgImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named:"bgWithLogo")
        imgView.sizeToFit()
         return imgView
    }()
    public lazy var lineImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named:"borderLine")
        imgView.sizeToFit()
        return imgView
    }()
    public lazy var line2ImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named:"borderLine")
        imgView.sizeToFit()
        return imgView
    }()
    public lazy var logoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named:"logo3")
        imgView.sizeToFit()
        return imgView
    }()
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Gakku TV"
        label.font = UIFont(name: Constant.Fonts.bold, size: Constant.FontSizes.bigger)
        label.textColor = .black
        return label
    }()
    var youtubeLabel: UILabel = {
        let label = UILabel()
        label.text = "youtube.com/gakkutv"
        label.font = UIFont(name: Constant.Fonts.regular, size: Constant.FontSizes.big)
        label.textColor = .gray
        return label
    }()
    var followersCountLabel = UILabel()
    var videosCountLabel = UILabel()
    var viewsCountLabel = UILabel()
    var followersLabel = UILabel()
    var videosLabel = UILabel()
    var viewsLabel = UILabel()
    public lazy var descriptionChannel: UILabel = {
        var text = UILabel()
        text.numberOfLines = 200
        text.font = UIFont(name: Constant.Fonts.regular, size: Constant.FontSizes.normal)
        
        text.textColor = .gray
        //        text.text = "Gakku TV - тек қана қазақстандық музыкаға арналған тұңғыш арна. Арна эфирінен отандық эстрада жұлдыздарының бұрыңғы жұмыстарымен қатар, заманауи әртістердің ең үздік туындыларын тамашалай аласыз. Gakku TV - Қазақстан эстрадасының антологиясы!"
        text.text = "    Gakku TV - это единственный музыкальный телеканал, посвященный исключительно казахстанской музыке. Эфир канала представляет собой плейлист из лучших работ прошлых лет и самых актуальных артистов современного Казахстана. Gakku TV - антология казахстанской эстрады!"
        return text
    }()
    public lazy var youtubeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "youtube"), for: .normal)
        return button
    }()
    public lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
        return button
    }()
    public lazy var instagramButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "instagram"), for: .normal)
        return button
    }()
    public lazy var googlePlusButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "googleplus"), for: .normal)
        return button
    }()
    public lazy var twitterButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "twitter"), for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.Titles.about
        configureView()
        configureConstraints()
        instagramButton.addTarget(self, action: #selector(instagramOpen
            ), for: .touchUpInside)
        youtubeButton.addTarget(self, action: #selector(youtubeOpen), for: .touchUpInside)
    }
    @objc func instagramOpen(){
        let link = ["app":"instagram://user?username=gakkutv","url":"https://www.instagram.com/gakkutv/"]
        openURL(links: link)
    }
    @objc func youtubeOpen(){
        let link = ["app":"youtube://6mWVW3K_WOc","url":"https://www.youtube.com/user/gakkutv"]
        openURL(links: link)
    }
    
    func openURL(links: Dictionary<String, String>){
        let hook = links["app"]!
        let hookURL = NSURL(string: hook)
        if UIApplication.shared.canOpenURL(hookURL! as URL)
        {
            UIApplication.shared.open(hookURL! as URL,options: [:],completionHandler: nil)
        } else {
            if let url = URL(string: links["url"]!) {
                UIApplication.shared.open(url, options: [:],completionHandler: nil)
            }
        }
        
    }
    func configureView(){
        [bgImageView, logoImageView,titleLabel,followersLabel,followersCountLabel,videosLabel,videosCountLabel,viewsLabel,viewsCountLabel,descriptionChannel,youtubeLabel,lineImageView,youtubeButton,facebookButton,twitterButton,instagramButton,googlePlusButton,line2ImageView].forEach {
            self.view.addSubview($0)
        }
        [followersCountLabel,videosCountLabel,viewsCountLabel].forEach{
            $0.font = UIFont(name: Constant.Fonts.bold, size: Constant.FontSizes.bigger)
            $0.textColor = .black
        }
         [followersLabel,videosLabel,viewsLabel].forEach{
            $0.font = UIFont(name: Constant.Fonts.bold, size: Constant.FontSizes.big)
            $0.textColor = .black
        }
        self.view.backgroundColor = .white
        followersCountLabel.text = "721K"
        videosCountLabel.text = "2K"
        viewsCountLabel.text = "481M"
        viewsLabel.text = "Views"
        followersLabel.text = "Followers"
        videosLabel.text = "Videos"
    }
    func configureConstraints(){
        constrain(bgImageView, titleLabel, logoImageView, view) { bg, tl, logo, v in
            bg.top == v.top + 55
            bg.left == v.left
            bg.width == v.width
            bg.height == bg.width/2
            
            bg.bottom == logo.top + 60
            logo.centerX == v.centerX
            
            logo.bottom == tl.top - 5
            tl.centerX == v.centerX
            
            //            tv.edges == v.edges
        }
        constrain(lineImageView, titleLabel, youtubeLabel, view) { li, tl, yL, v in
            tl.bottom == yL.top
            yL.centerX == v.centerX
            
            yL.bottom == li.top - 10
            li.centerX == v.centerX
            
        }
        constrain(lineImageView, followersCountLabel, followersLabel , view) { li, fcount, fl ,v in
            fcount.left == v.left + 30
            fcount.top == li.bottom + 10
            fl.left == v.left + 30
            fl.top == fcount.bottom + 5
        }
        constrain(lineImageView, viewsCountLabel, viewsLabel, view) { li, vcount, vl ,v in
            vcount.right == v.right - 30
            vcount.top == li.bottom + 10
            vl.right == v.right - 30
            vl.top == vcount.bottom + 5
            
        }
        constrain(lineImageView, videosCountLabel, videosLabel, view) { li, vidcount, vidl ,v in
            vidcount.centerX == v.centerX
            vidcount.top == li.bottom + 10
            vidl.centerX == v.centerX
            vidl.top == vidcount.bottom + 5
        }
        constrain(line2ImageView, videosLabel, view) { li, vidl, v in
            vidl.bottom == li.top - 10
            li.centerX == v.centerX
        }
        constrain(line2ImageView, descriptionChannel, view){ li, dc, v in
            dc.top == li.bottom + 10
            dc.left == v.left + 10
            dc.width == v.width - 20
            
        }
        constrain(youtubeButton, instagramButton, googlePlusButton, view, facebookButton){ yV, iV, gp, v, fv in
            yV.bottom == v.bottom - 65
            yV.centerX == v.centerX
            
            iV.top == yV.top
            iV.right == yV.left - 10
            
            gp.top == yV.top
            gp.right == iV.left - 10
            
            fv.top == yV.top
            fv.left == yV.right + 10
            
        }
        constrain(twitterButton, view, facebookButton){ tv, v, fv in
            tv.top == fv.top
            tv.left == fv.right + 10
            
        }
    }
}

