//
//  FinalParagraphCell.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/10/10.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class FinalParagraphCell: BasicCell {
    fileprivate lazy var websiteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Visit ICDF", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.blueBackgroundColor
        btn.addTarget(self, action: #selector(goToICDFWebsite), for: .touchUpInside)
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()
    
    @objc func goToICDFWebsite(){
    }
    
    override func setupViews() {
        backgroundColor = UIColor.blueBackgroundColor
        setupUI()
    }
}

extension FinalParagraphCell{
    fileprivate func setupUI(){
        addSubview(websiteButton)
        websiteButton.anchor(top: topAnchor, bottom: nil, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: ICDFINtroductionConstant.FinalParagraphWeidth.rawValue, height: ICDFINtroductionConstant.FinalParagraphHeight.rawValue)
        websiteButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        websiteButton.setShadow(shadowColor: UIColor.shadowColor, shadowOpacity: 1.0, offsetWidth: 10, offsetHeight: 10)
    }
}
