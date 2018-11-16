//
//  LowerBackgroundView.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/10/6.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class LowerBackgroundView: BasicView {
    fileprivate var introductionParagraph: ICDFIntrodutionParagraph?{
        didSet{
            guard let introductionParagraph = introductionParagraph else {return}
            setParagraph(introductionParagraph: introductionParagraph)
        }
    }
    
    
    
    fileprivate let paragraphLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    
    override func setupViews() {
    }

}


extension LowerBackgroundView{
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
        addSubview(paragraphLabel)
        paragraphLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 35, leftPadding: 30, rightPadding: 30, width: 0, height: 0)
        
    }
    
    
    fileprivate func setupCommonParagraph(){
        addSubview(paragraphLabel)
        paragraphLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 120, bottomPadding: 35, leftPadding: 30, rightPadding: 30, width: 0, height: 0)
    }
    
    fileprivate func setParagraph(introductionParagraph: ICDFIntrodutionParagraph){
        paragraphLabel.textColor = introductionParagraph.textColor
        setParagraphLabelAttributed(str: introductionParagraph.paragraphText)
    }
    
    fileprivate func setParagraphLabelAttributed(str: String){
        let paragraphStyle = NSMutableParagraphStyle()
        //line height size
        paragraphStyle.lineSpacing = 10.0
        let attrString = NSMutableAttributedString(string: str)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        paragraphLabel.attributedText = attrString
        paragraphLabel.textAlignment = NSTextAlignment.left
    }
    
}
