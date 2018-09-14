//
//  InformationTableViewCell.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/2.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import WebKit

enum TitleName: String {
    case type = "Type"
    case location = "Location"
    case phone = "Phone"
    case time = "Time"
    case website = "Website"
}

enum ImgName: String{
    case time = "time"
    case location = "location"
    case ninja = "ninja"
    case type = "Type"
    case Phone = "Phone"
    case Website = "Website"
}
protocol InformationTableViewCellDelegate {
    func showWebView()
}

class InformationTableViewCell: BasicTableViewCell {
    var delegate: InformationTableViewCellDelegate?
    var place: Place?{
        didSet{
            guard let place = place else {return}
            timeView.setupValues(title: TitleName.time.rawValue, subTitle: place.openingTime, imgName: ImgName.time.rawValue)
            typeView.setupValues(title: TitleName.type.rawValue, subTitle: place.type, imgName: ImgName.type.rawValue)
            locationView.setupValues(title: TitleName.location.rawValue, subTitle: place.address, imgName: ImgName.location.rawValue)
            phoneView.setupValues(title: TitleName.phone.rawValue, subTitle: place.phone, imgName: ImgName.Phone.rawValue)
            webSiteView.setupValues(title: ImgName.Website.rawValue, subTitle: place.website, imgName: ImgName.Website.rawValue)
            
            if place.website != "none"{
                webSiteView.changeSubtitleFontToItalic()
            }
            guard let url = URL(string: place.website)  else {
                return
            }
            webView.loadRequest(URLRequest(url: url))
            addSubview(webView)
            webView.anchor(top: webSiteView.bottomAnchor, bottom: bottomAnchor, left: webSiteView.leftAnchor, right: webSiteView.rightAnchor, topPadding: 20, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        }
    }
    
    var isWebsite: Bool?
    
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
    
    lazy var webSiteView: InformationView = {
        let view = InformationView()
        view.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToWebVC))
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()
    
    @objc func goToWebVC(){
        guard let place = place  else {return}
        if place.website != "none"{
             delegate?.showWebView()
             webSiteView.websiteViewIsShowed()
        }
    }
    
    lazy var webView: UIWebView = {
        let wv = UIWebView()
        wv.delegate = self
        return wv
    }()
    
//    lazy var webView: UIView = {
//        let wv = UIView()
//        wv.backgroundColor = UIColor.red
//        return wv
//    }()
//
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
        
        addSubview(webSiteView)
        webSiteView.anchor(top: phoneView.bottomAnchor, bottom: nil, left: timeView.leftAnchor, right: timeView.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: timeView.frame.height)
    }
    
   
}


extension InformationTableViewCell: UIWebViewDelegate{
    
}
