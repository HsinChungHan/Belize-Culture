//
//  ParagraphCell.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/10/6.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ParagraphCell: BasicCell {
    fileprivate var introductionParagraph: ICDFIntrodutionParagraph?{
        didSet{
            guard let introductionParagraph = introductionParagraph else {return}
            setBackgroundViewColor(introductionParagraph: introductionParagraph)
            paraghImgView.setValue(introductionParagraph: introductionParagraph)
            lowerBackgroundView.setValue(introductionParagraph: introductionParagraph)
        }
    }
    fileprivate let upperBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    fileprivate lazy var paraghImgView: ParaghImageView = {
        let piv = ParaghImageView()
        return piv
    }()
    
    fileprivate let lowerBackgroundView: LowerBackgroundView = {
        let view = LowerBackgroundView()
        return view
    }()
    
    override func setupViews() {
        
    }
}

extension ParagraphCell{
    public func setValue(introductionParagraph: ICDFIntrodutionParagraph){
        self.introductionParagraph = introductionParagraph
    }
    
    public func setupUI(indexPath: IndexPath){
        paraghImgView.setupUI(indexPath: indexPath)
        lowerBackgroundView.setupUI(indexPath: indexPath)
        if indexPath.item == 0{
            setupFirstParagraph()
        }else{
            setupCommonParagraph()
        }
    }
    
    fileprivate func setupFirstParagraph(){
        addSubview(paraghImgView)
        paraghImgView.anchor(top: topAnchor, bottom: nil, left: nil, right: nil, topPadding: 20, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: ICDFINtroductionConstant.PargaraphLogoImgWidth.rawValue, height: ICDFINtroductionConstant.PargaraphLogoImgHeight.rawValue)
        paraghImgView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(lowerBackgroundView)
        lowerBackgroundView.backgroundColor = .red
        lowerBackgroundView.anchor(top: paraghImgView.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
    }
    
    
    
    fileprivate func setupCommonParagraph() {
        addSubview(upperBackgroundView)
        upperBackgroundView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: ICDFINtroductionConstant.ParagraphImageViewHeight.rawValue/2)
        addSubview(lowerBackgroundView)
        lowerBackgroundView.anchor(top: upperBackgroundView.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        addSubview(paraghImgView)
        paraghImgView.anchor(top: topAnchor, bottom: nil, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: ICDFINtroductionConstant.ParagraphImageViewWidth.rawValue, height: ICDFINtroductionConstant.ParagraphImageViewHeight.rawValue)
        paraghImgView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    fileprivate func setBackgroundViewColor(introductionParagraph: ICDFIntrodutionParagraph){
        upperBackgroundView.backgroundColor = introductionParagraph.upperBackgroundColor
        lowerBackgroundView.backgroundColor = introductionParagraph.lowerBackgroundColor
    }
    
    
}
