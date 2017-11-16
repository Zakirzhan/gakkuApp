//
//  YoutubeVideoTableViewCell.swift
//  GakkuApp
//
//  Created by macbook on 03.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
import SDWebImage


class RadioTableViewCell: UITableViewCell {
    
    fileprivate lazy var shadowView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return shadowView
    }()
    lazy var favIcon: UIImageView = {
        let favIcon = UIImageView()
        favIcon.image = UIImage(named: "fav")
        return favIcon
    }()
    lazy var nowPlaying: UIImageView = {
        let now = UIImageView()
        return now
    }()
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: Constant.Fonts.bold, size: Constant.FontSizes.big)
        return label
    }()
    public lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: Constant.Fonts.regular, size: Constant.FontSizes.normal)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        [nowPlaying,titleLabel,durationLabel,favIcon].forEach{
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        constrain(self, titleLabel, durationLabel, nowPlaying, favIcon) { s, tl, dl, nl, fav in
            nl.left == s.left + 10
            nl.centerY == s.centerY
            
            tl.left ==  s.left  + 50
            tl.centerY == s.centerY
            
            dl.right == s.right - 10
            dl.centerY == s.centerY
            
            fav.right == dl.left - 30
            fav.centerY == s.centerY
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
     }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
 
