//
//  TVProgrammsCollectionViewCell.swift
//  GakkuApp
//
//  Created by Dayana Marden on 16.08.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

class TVProgrammsCollectionViewCell: UICollectionViewCell {
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.Fonts.bold, size: Constant.FontSizes.big)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }() 
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.Fonts.regular, size: Constant.FontSizes.normal)
        label.numberOfLines = 5
        label.textColor = .white
        return label
    }()
    
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: Constant.Fonts.regular, size: Constant.FontSizes.normal)
         label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints() 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        [titleLabel,dateLabel,descriptionLabel].forEach{
            self.addSubview($0)
        }
    }
    
    func configureConstraints() { 
        constrain(self,titleLabel, dateLabel, descriptionLabel){s,title, date, desc in
            date.left == s.left + 5
            date.top == s.top + 5
            
            
            title.top == date.bottom + 3
            title.left == s.left + 5
            title.width == s.width - 10
            
            desc.top == title.bottom + 3
            desc.left == s.left + 5
            desc.width == s.width - 10
            
            
        }
        
    }
}
