//
//  DirectionView.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/13.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class DirectionView: BasicView {
    var clue: String?{
        didSet{
            clueLabel.text = clue
        }
    }
    
    var arrow: String?{
        didSet{
            guard let arrow = arrow else {return}
            directionArrowImgView.image = UIImage(named: arrow)?.withRenderingMode(.alwaysTemplate)
            directionArrowImgView.tintColor = .white
        }
    }
    
    let directionArrowImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "rightDirectionArrow")?.withRenderingMode(.alwaysTemplate)
        imv.contentMode = .scaleAspectFit
        imv.tintColor = .white
        return imv
    }()
    
    let clueLabel: UILabel = {
        let label = UILabel()
        label.text = ClueConstant.tapPlaceIcon.rawValue
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    override func setupViews() {
        setupAllViews()
    }
}


extension DirectionView{
    fileprivate func setupAllViews(){
        addSubview(directionArrowImgView)
        addSubview(clueLabel)
        directionArrowImgView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 100)
        clueLabel.anchor(top: directionArrowImgView.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
    }
    
    public func setValue(clue: String, arrow: String = "rightDirectionArrow"){
        self.clue = clue
        self.arrow = arrow
    }
    
   
}
