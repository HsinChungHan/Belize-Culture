//
//  ICDFIntroduction.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/10/7.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
class ICDFIntrodutionParagraph{
    let paragraphText: String, image: UIImage, upperImgColor: UIColor, lowerImgColor: UIColor, upperBackgroundColor: UIColor, lowerBackgroundColor: UIColor, textColor: UIColor
    init(paragraphText: String, image: UIImage, upperImgColor: UIColor, lowerImgColor: UIColor, upperBackgroundColor: UIColor, lowerBackgroundColor: UIColor, textColor: UIColor) {
        self.paragraphText = paragraphText
        self.image = image
        self.upperImgColor = upperImgColor
        self.lowerImgColor = lowerImgColor
        self.upperBackgroundColor = upperBackgroundColor
        self.lowerBackgroundColor = lowerBackgroundColor
        self.textColor = textColor
    }
    
    static func getAllParagraphs() -> ([ICDFIntrodutionParagraph]){
        var paragraphs = [ICDFIntrodutionParagraph]()
        let firstParagraph = ICDFIntrodutionParagraph
        return paragraphs
    }
}
