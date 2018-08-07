//
//  CAGradientLayer_Extension.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/24.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension CAGradientLayer{
    func setGradientLayer(view: UIView, colors: [UIColor]){
        view.layoutIfNeeded()
        self.frame = view.bounds
        var cgColors = [CGColor]()
        for color in colors{
            cgColors.append(color.cgColor)
        }
        self.colors = cgColors
        view.layer.addSublayer(self)
    }
    
    func setGradientLayer(view: UIButton, colors: [UIColor], cornerRadius: CGFloat){
        view.layoutIfNeeded()
        self.frame = view.bounds
        self.cornerRadius = cornerRadius
        var cgColors = [CGColor]()
        for color in colors{
            cgColors.append(color.cgColor)
        }
        self.colors = cgColors
        view.layer.insertSublayer(self, below: view.titleLabel?.layer)
    }
    
    func setGradientLayer(view: UIButton, colors: [UIColor], below sublayer: CALayer){
        view.layoutIfNeeded()
        self.frame = view.bounds
        var cgColors = [CGColor]()
        for color in colors{
            cgColors.append(color.cgColor)
        }
        self.colors = cgColors
        view.layer.insertSublayer(self, below: sublayer)
    }
}
