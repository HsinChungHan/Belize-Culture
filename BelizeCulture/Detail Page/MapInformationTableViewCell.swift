//
//  MapInformationTableViewCell.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/2.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import MapKit
protocol GoToMapVCDelegate {
    func goToMapVC()
}


class MapInformationTableViewCell: BasicTableViewCell {
    var goToMapVCDelegate: GoToMapVCDelegate?
    lazy var mapImgView: UIImageView = {
       let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()
    
    var place: Place? {
        didSet{
            guard let place = place else {return}
            mapImgView.image = UIImage(named: place.mapImg)
        }
    }
    
    
    lazy var detailMapButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(">", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(goToMapVC), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        //        btn.setImage(UIImage(named: "")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    @objc func goToMapVC(){
        goToMapVCDelegate?.goToMapVC()
    }
    
    override func setupViews() {
        setupMapImgView()
        setupDetailMapButton()
    }

}

extension MapInformationTableViewCell{
    fileprivate func setupMapImgView(){
        addSubview(mapImgView)
        mapImgView.fullAnchor(superView: self)
    }
    
    fileprivate func setupDetailMapButton(){
        addSubview(detailMapButton)
        detailMapButton.anchor(top: topAnchor, bottom: nil, left: nil, right: rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 0, rightPadding: 20, width: 40, height: 40)
    }
    
}

