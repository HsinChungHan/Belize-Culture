//
//  ParaghImageView.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/10/6.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ParaghImageView: BasicView {
    fileprivate var introductionParagraph: ICDFIntrodutionParagraph?{
        didSet{
            guard let introductionParagraph = introductionParagraph else {return}
            setImgBackgroundViewColor(introductionParagraph: introductionParagraph)
            setImgView(introductionParagraph: introductionParagraph)
        }
    }
    
    fileprivate let upperView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.appleGreenBackgroundColor
        return view
    }()
    
    fileprivate let lowerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    fileprivate let imgView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()
    
    
    
    override func setupViews() {
    }
}

extension ParaghImageView{
    public func setValue(introductionParagraph: ICDFIntrodutionParagraph){
        self.introductionParagraph = introductionParagraph
    }
    
    public func setupUI(indexPath: IndexPath){
        if indexPath.item == 0{
            setupFirstParagraph()
        }else{
            setupCommonParagraph()
        }
    }
    
    fileprivate func setupFirstParagraph(){
        addSubview(imgView)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = false
        imgView.fullAnchor(superView: self)
    }
    
    fileprivate func setupCommonParagraph(){
        addSubview(upperView)
        upperView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: ICDFINtroductionConstant.ParagraphImageViewHeight.rawValue/2)
        
        addSubview(lowerView)
        lowerView.anchor(top: upperView.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        addSubview(imgView)
        imgView.centerAnchor(superView: self, width: ICDFINtroductionConstant.ParagraphImageViewWidth.rawValue - ICDFINtroductionConstant.ParagraphImageViewPadding.rawValue , height: ICDFINtroductionConstant.ParagraphImageViewHeight.rawValue - ICDFINtroductionConstant.ParagraphImageViewPadding.rawValue)
    }
    
    
    
    fileprivate func setImgBackgroundViewColor(introductionParagraph: ICDFIntrodutionParagraph){
        upperView.backgroundColor = introductionParagraph.upperImgColor
        lowerView.backgroundColor = introductionParagraph.lowerImgColor
    }
    
    fileprivate func setImgView(introductionParagraph: ICDFIntrodutionParagraph){
        imgView.image = introductionParagraph.image
    }
    
   
}
