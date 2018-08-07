//
//  InformationTableViewCell.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/2.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
enum TitleName: String {
    case type = "Type"
    case location = "Location"
    case phone = "Phone"
    case time = "Time"
}

enum ImgName: String{
    case time = "time"
    case location = "location"
    case ninja = "ninja"
}


class InformationTableViewCell: BasicTableViewCell {
    var height: CGFloat = 250
    var place: Place?{
        didSet{
            guard let place = place else {return}
            timeView.setupValues(title: TitleName.time.rawValue, subTitle: place.time, imgName: ImgName.time.rawValue)
            typeView.setupValues(title: TitleName.type.rawValue, subTitle: place.type, imgName: ImgName.ninja.rawValue)
            locationView.setupValues(title: TitleName.location.rawValue, subTitle: place.location, imgName: ImgName.location.rawValue)
            phoneView.setupValues(title: TitleName.phone.rawValue, subTitle: place.phone, imgName: ImgName.ninja.rawValue)
        }
    }
    
    lazy var timeView: InformationView = {
        let view = InformationView()
        return view
    }()
    
    lazy var typeView: InformationView = {
        let view = InformationView()
        return view
    }()
    
    lazy var locationView: InformationView = {
        let view = InformationView()
        return view
    }()
    
    lazy var phoneView: InformationView = {
        let view = InformationView()
        return view
    }()
    
    override func setupViews() {
        selectionStyle = .none
        addSubview(timeView)
        timeView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 50)
        layoutIfNeeded()
        addSubview(typeView)
        typeView.anchor(top: timeView.bottomAnchor, bottom: nil, left: timeView.leftAnchor, right: timeView.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: timeView.frame.height)
        
        addSubview(locationView)
        locationView.anchor(top: typeView.bottomAnchor, bottom: nil, left: timeView.leftAnchor, right: timeView.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: timeView.frame.height)
        
        addSubview(phoneView)
        phoneView.anchor(top: locationView.bottomAnchor, bottom: nil, left: timeView.leftAnchor, right: timeView.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: timeView.frame.height)
        
    }

}
