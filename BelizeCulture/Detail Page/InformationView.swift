//
//  SelectedInformationView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit



class InformationView: BasicView {
    let textBrownColor = UIColor.rgb(red: 132, green: 94, blue: 85)
    fileprivate var imgName: String?{
        didSet{
            guard let imgName = imgName else {return}
            iconImgView.image = UIImage(named: imgName)
        }
    }
    
    fileprivate var title: String?{
        didSet{
            guard let title = title else {return}
            titleLabel.text = title
        }
    }
    
    fileprivate var subTitle: String?{
        didSet{
            guard let subTitle = subTitle else {return}
            subTitleLabel.text = subTitle
            subTitleLabel.numberOfLines = 0
            subTitleLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    fileprivate let iconImgView: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = textBrownColor
        return label
    }()
    
    fileprivate lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.darkBlueColor
        return label
    }()
    
    override func setupViews() {
        backgroundColor = .clear
        addSubview(iconImgView)
        iconImgView.anchor(top: nil, bottom: nil, left: leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 18, height: 25)
        iconImgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: iconImgView.centerYAnchor).isActive = true
        titleLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: iconImgView.rightAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 130, height: 0)
        
        addSubview(subTitleLabel)
        subTitleLabel.anchor(top: titleLabel.topAnchor, bottom: titleLabel.bottomAnchor, left: titleLabel.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 0, height: 0)
    }
    

}


extension InformationView{
    public func setupValues(title: String, subTitle: String, imgName: String){
        self.title = title
        self.subTitle = subTitle
        self.imgName = imgName
    }
    
    public func fetchWebsite() -> String?{
        if subTitle != "none"{
            return subTitle
        }
        return nil
    }
    
    public func changeSubtitleFontToItalic(){
            subTitleLabel.font = UIFont.italicSystemFont(ofSize: 22)
            subTitleLabel.textColor = UIColor.skyBlue
    }
    
    public func websiteViewIsShowed(){
        subTitleLabel.font = UIFont.systemFont(ofSize: 22)
        subTitleLabel.textColor = UIColor.black
        isUserInteractionEnabled = false
    }
}
