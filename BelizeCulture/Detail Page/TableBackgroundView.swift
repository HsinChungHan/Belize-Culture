//
//  TableHeaderView.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/3.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class TableBackgroundView: BasicView {
    
    var img: String?{
        didSet{
            guard let img = img else {return}
            backGroundImgView.image = UIImage(named: img)
        }
    }
    
  
    let backGroundImgView: UIImageView = {
       let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.image = UIImage(named: "test1")
        return imv
    }()
    
    
    override func setupViews() {
        setupImgViews()
    }

}

extension TableBackgroundView{
    fileprivate func setupImgViews(){
        addSubview(backGroundImgView)
        backGroundImgView.fullAnchor(superView: self)
        
    }
    
    public func setImgValue(img: String){
        self.img = img
    }
}
