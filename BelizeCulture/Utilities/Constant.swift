//
//  Constant.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/2.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation

import UIKit
enum HeightConstant: CGFloat {
    case plcacImgView = 500
    case sectionHaderView = 150
    case mapCell = 400
    case popView = 300
    case storyCell = 600
}


enum WidthConstant: CGFloat {
    case popView = 400
}


enum PlaceIconConstant: String{
    case Court = "Court"
    case Park = "Park"
    case OldHouse = "OldHouse"
    case HOC = "HOC"
    case Johns = "Johns"
    case Plaza = "Plaza"
    case BBall = "BBall"
}


enum SegmentedControlConstant:String {
    case information = "Information"
    case story = "Story"
}


enum IndexPathConstant: Int{
    case informationCell = 0
    case mapCell = 1
}
