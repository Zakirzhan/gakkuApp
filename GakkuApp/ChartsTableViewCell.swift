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


class ChartsTableViewCell: UITableViewCell {
    
    private var layoutConfigured = false
    
    
    
    private var group = ConstraintGroup()
    public lazy var postImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.Fonts.bold, size: Constant.FontSizes.big)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.Fonts.regular, size: Constant.FontSizes.normal)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: Constant.Fonts.regular, size: Constant.FontSizes.normal)
        label.textColor = .gray
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
        self.addSubview(postImageView)
        self.addSubview(titleLabel)
        self.addSubview(dateLabel)
        self.addSubview(descriptionLabel)
    }
    
    func configureConstraints() {
        
        constrain(self,postImageView,titleLabel,descriptionLabel){s,img,title,d in
            img.top == s.top + 10
            img.left == s.left + 16
            img.bottom == s.bottom - 5
            img.height == s.width/4 - 15
            img.width == 2*s.width/5 - 16
            title.top == s.top + 10
            title.left == img.right + 16
            title.width == 3*s.width/5 - 16
            
            
            d.width == 3*s.width/5 - 16
            d.top == title.bottom + 5
            d.left == img.right + 16
            
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func configure(with video: YoutubeParser) {
        if let imageLink = video.imageLink,
            let url = URL(string: imageLink){
            postImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "no-image"))
        }
        titleLabel.text = video.title
        descriptionLabel.text = video.description
        
        guard let dateString = video.date else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = dateFormatter.date(from: dateString) else { return }
        
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        dateLabel.text = dateFormatter.string(from: date)
    }
    
}
