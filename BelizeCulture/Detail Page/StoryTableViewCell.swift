//
//  StoryTableViewCell.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/2.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class StoryTableViewCell: BasicTableViewCell {
    var place: Place? {
        didSet{
            guard let place = place else {return}
            //之後要把每個都點湊到4張照片以上
            if place.imgs.count < 4{
                firstContent = (place.imgs[1], place.mandarinStory)
                secondContent = (place.imgs[0], place.englishStory)
                thirdContent = (place.imgs[1], place.mandarinStory)
            }else{
                firstContent = (place.imgs[1], place.mandarinStory)
                secondContent = (place.imgs[2], place.englishStory)
                thirdContent = (place.imgs[3], place.mandarinStory)
            }
            
            if place.englishName == "Belize Welcome Sign"{
                thirdContent = ("BelizeSign3", "\t\tBelize Welcome Sign附近有一座潔白的燈塔，燈塔下面有一方墓碑形狀的紀念碑。據信很久以前有位富有的貝里斯人，過世後將自己龐大的遺產捐給貝里斯政府。\n\t\t貝里斯政府特建立這個燈塔及紀念碑，來緬懷這位貝里斯人高尚無私的作為。")
            }
            
        }
    }
    
    var firstContent: (image: String, text: String)?{
        didSet{
            guard let img = firstContent?.image, let text = firstContent?.text  else {
                return
            }
            firstInfoView.setContent(image: img, text: text)
        }
    }
    var secondContent: (image: String, text: String)?{
        didSet{
            guard let img = secondContent?.image, let text = secondContent?.text  else {
                return
            }
            secondInfoView.setContent(image: img, text: text)
        }
    }
    
    var thirdContent: (image: String, text: String)?{
        didSet{
            guard let img = thirdContent?.image, let text = thirdContent?.text  else {
                return
            }
            thirdInfoView.setContent(image: img, text: text)
        }
    }
    
    let firstInfoView: StoryInformationView = {
       let siv = StoryInformationView()
        return siv
    }()
    
    let secondInfoView: StoryInformationView = {
        let siv = StoryInformationView()
        return siv
    }()
    
    let thirdInfoView: StoryInformationView = {
        let siv = StoryInformationView()
        return siv
    }()
    
    override func setupViews() {
        selectionStyle = .none
        backgroundColor = UIColor.backgroundRiceColor
        setupStoryInformationViews()
    }

}


extension StoryTableViewCell{
    fileprivate func setupStoryInformationViews(){
        addSubview(firstInfoView)
        addSubview(secondInfoView)
        addSubview(thirdInfoView)
        firstInfoView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 20, rightPadding: 20, width: 0, height: 300)
        firstInfoView.layoutIfNeeded()
        secondInfoView.anchor(top: firstInfoView.bottomAnchor, bottom: nil, left: firstInfoView.leftAnchor, right: firstInfoView.rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: firstInfoView.bounds.height)
        thirdInfoView.anchor(top: secondInfoView.bottomAnchor, bottom: nil, left: firstInfoView.leftAnchor, right: firstInfoView.rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: firstInfoView.bounds.height)
        firstInfoView.setupImgLeftLabelRight()
        secondInfoView.setupImgRightLabelLeft()
        thirdInfoView.setupImgLeftLabelRight()
    }
    
    public func setupValues(place: Place?){
        self.place = place
    }
}
