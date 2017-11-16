//
//  NewsCollectionViewCell.swift
//  GakkuApp
//
//  Created by macbook on 03.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//
import UIKit
import Cartography
import SDWebImage

class NewsCollectionViewCell: UICollectionViewCell {
    public lazy var postImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    fileprivate lazy var shadowView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        return shadowView
    }()
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font =  UIFont(name: Constant.Fonts.bold, size: Constant.FontSizes.big)
        label.textColor = .white
        return label
    }()
    
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: Constant.Fonts.regular, size: Constant.FontSizes.normal)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    func configureViews(){
        [postImageView,titleLabel,dateLabel].forEach{
            self.addSubview($0)
        }
        postImageView.addSubview(shadowView)
     }
    
    func configureConstraints() {
        constrain(self, postImageView, titleLabel, dateLabel, shadowView) { s, img, tl, dl, shadow in
            img.edges == s.edges
            shadow.edges == img.edges
            tl.bottom == s.bottom - 10
            tl.left == s.left + 10
            tl.width == s.width - 20
        }
        
    }

}
