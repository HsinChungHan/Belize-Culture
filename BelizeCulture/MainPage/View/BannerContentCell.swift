//
//  BannerContentCell.swift
//  BelizeBuyAndSell
//
//  Created by 辛忠翰 on 27/03/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class BannerContentCell: BasicCell {
    
    let titlelabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "PingFangTC-Medium", size: 20)
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override func setupViews() {
        setupImageView()
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.fullAnchor(superView: self)
        imageView.addSubview(titlelabel)
//        titlelabel.anchor(top: nil, bottom: imageView.bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 40, leftPadding: 0, rightPadding: 0, width: 200, height: 30)
//        titlelabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
    }
}

