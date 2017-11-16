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


class CategoriesTableViewCell: UITableViewCell {
    
    
    private var group = ConstraintGroup()
    
    public lazy var postImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    fileprivate lazy var shadowView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = Constant.Colors.shadow
        
        return shadowView
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: Constant.Fonts.bold, size: Constant.FontSizes.bigger)
        label.textColor = .white
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
        [postImageView,shadowView,titleLabel].forEach {
            self.addSubview($0)
        } 
    }
    
    func configureConstraints() {
        constrain(self, postImageView, titleLabel, shadowView) { s, img, tl, shadow in
            img.edges == s.edges
            shadow.edges == img.edges
            tl.center == s.center
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with playlist: MyPage) {
        titleLabel.text = playlist.title?.uppercased()
        if let imageLink = playlist.imageLink,
            let url = URL(string: imageLink){
            postImageView.sd_showActivityIndicatorView()
            postImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "logo2"))

            postImageView.sd_removeActivityIndicator()
        }
    }
    
}
