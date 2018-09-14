//
//  StoryInformationView.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/8.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class StoryInformationView: BasicView {
    
    lazy var imgView: UIImageView = {
       let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.image = UIImage(named: "test1")
        return imv
    }()
    
    let storylabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override func setupViews() {
        backgroundColor = .clear
    }
   
    public func setupImgLeftLabelRight(){
        addSubview(imgView)
        addSubview(storylabel)
        imgView.anchor(top: nil, bottom: nil, left: leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 20, rightPadding: 0, width: UIScreen.main.bounds.width/2, height: 300)
        imgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        storylabel.anchor(top: imgView.topAnchor, bottom: imgView.bottomAnchor, left: imgView.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 20, rightPadding: 20, width: 0, height: 0)
        
    }
    
    public func setupImgRightLabelLeft(){
        addSubview(imgView)
        addSubview(storylabel)
        imgView.anchor(top: nil, bottom: nil, left: nil, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 20, width: UIScreen.main.bounds.width/2, height: 300)
        imgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        storylabel.anchor(top: imgView.topAnchor, bottom: imgView.bottomAnchor, left: leftAnchor , right: imgView.leftAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 20, rightPadding: 20, width: 0, height: 0)
    }
    
    public func setContent(image: String, text: String){
        imgView.image = UIImage(named: image)
        storylabel.text = text
    }

}
