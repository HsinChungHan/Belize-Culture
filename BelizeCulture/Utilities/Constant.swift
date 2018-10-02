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
    case mapCell = 550
    case popView = 400
    case storyCell = 1030
    case informationCell = 320
}

enum RowNumberConstant: Int {
    case story = 2
//    case story = 2
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
    case Yarborough = "Yarborough"
    case BelizeSign = "BelizeSign"
}


enum PlaceButtonTag: Int{
    case HOC = 0
    case Court = 1
    case HumanDevelopmentBuilding = 2
    case CockburnLaneHouse = 3
    case PaslowPlaza = 4
    case Yarborough = 5
    case BattlefieldPark = 6
    case SwingBridge = 7
    case MulePark = 8
    case WesleyChurch = 9
    case EuseyHouse = 10
    case BelizeWelcomeSign = 11
    case Johns = 12
}



enum SegmentedControlConstant:String {
    case information = "Information"
    case story = "Story"
}


enum IndexPathConstant: Int{
    case informationCell = 0
    case mapCell = 1
}


enum IconsConstant: String{
    case menuEvents = "MenuEvents"
    case menuFood = "MenuFood"
    case menuShowRd = "MenuShowRd"
    case menuMonument = "MenuMonument"
    case Menu = "Menu"
    case DisplayMode = "DisplayMode"
    case back = "Back"
}




enum BelizeCultureJSONConstant: String{
    case englishName = "englishName"
    case mandarinName = "mandarinName"
    case address = "address"
    case latitude = "latitude"
    case longitude = "longitude"
    case type = "type"
    case phone = "phone"
    case openingTime = "openingTime"
    case imgs = "imgs"
    case englishStory = "englishStory"
    case mandarinStory = "mandarinStory"
    case mapImg = "mapImg"
    case iconImg = "iconImg"
    case website = "website"
    case iconLocation = "iconLocation"
    case isLiked = "isLiked"
    case iconLocationX = "iconLocationX"
    case iconLocationY = "iconLocationY"
    case englishStoryFirst = "englishStoryFirst"
    case englishStorySecond = "englishStorySecond"
    case englishStoryThird = "englishStoryThird"
    case mandarinStoryFirst = "mandarinStoryFirst"
    case mandarinStorySecond = "mandarinStorySecond"
    case mandarinStoryThird = "mandarinStoryThird"
    
}



enum ClueConstant: String{
    case tapPlaceIcon = "Please tap this twinkle icon -- St. John's Church!"
    case tapMoreToDetailView = "Good Job! \n Next, click ▷ to see more information about St. John's Church!"
    
    case slideToGetMoreStory = "Welcomw to Belize Sign! \n 讓我們往上滑動看看更多關於Belize Welcome Sign的故事吧！"
    
    case tapInformationSegmentControl = "Good job!\n接下來讓我們點擊Information按鈕，來看看Belize Sign有哪些更進一步的資訊吧！"
    
    case personCaptionLabel = "Hi there, I heard that there are photos of Taiwan president at Belize Sign. Let’s take a look！"
    case belizeCultureDirectionView = "Please click on the shiny Belize Sign in the upper right corner to look presendent's photos!"
}


