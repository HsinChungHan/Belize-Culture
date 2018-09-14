//
//  Restaurant.swift
//  PinFood
//
//  Created by Mahmoud RACHID on 24/02/2017.
//  Copyright © 2017 Mahmoud RACHID. All rights reserved.
//

import Foundation
import UIKit

class Place{
//
//    let type: String, englishName: String, address: String, image: String, phone: String, openingTime: String
//    let imgs:[String], mapImg: String
//    var isLiked: Bool
//    let iconLocation: (x: CGFloat, y: CGFloat)
//    let mandarinName: String
//    let coordinate: (latitude: CGFloat, longitude: CGFloat)
//    let website: String
//    let englishStory: String, mandarinStory: String
//
//    init(englishName: String, mandarinName: String = "文化之家", type: String, location: String, phone : String, image: String, imgs: [String] = ["test1", "test2", "test3", "test4"], time: String = "10:00 ~ 18:00", mapImg: String = "mapImg", isLiked: Bool = false, iconLocation:(x: CGFloat, y: CGFloat) = (0,0), coordinate: (latitude: CGFloat, longitude: CGFloat) = (17,-88), website: String = "https://google.com/", englishStory: String = "", mandarinStory: String = "" ) {
//
//        self.englishName = englishName
//        self.mandarinName = mandarinName
//        self.type = type
//        self.address = location
//        self.image = image
//        self.phone = phone
//        self.imgs = imgs
//        self.openingTime = time
//        self.mapImg = mapImg
//        self.isLiked = isLiked
//        self.iconLocation = iconLocation
//        self.coordinate = coordinate
//        self.website = website
//        self.englishStory = englishStory
//        self.mandarinStory = mandarinStory
//    }
//
//    static func oneTestPlace() -> Place{
//        return Place(englishName: "Cafe Deadend", type: "Coffee & Tea Shop", location: "110 St Marks Pl New York, NY 10009", phone: "232-923423", image: "cafedeadend", imgs: ["a1", "a2", "a3", "a4"])
//
//    }
//
//    static func allPlaces() -> [Place]{
//        return [
//            Place(englishName: PlaceIconConstant.Johns.rawValue, type: "Coffee & Tea Shop", location: "110 St Marks Pl New York, NY 10009", phone: "232-923423", image: "a1", imgs: ["a1", "a2", "a3", "a4"], iconLocation: (248,727)),
//            Place(englishName: PlaceIconConstant.HOC.rawValue, type: "Cafe", location: "524 Ct St, Brooklyn, NY 11231", phone: "348-233423", image: "b1", imgs: ["b1", "b2", "b3"], iconLocation: (518,636)),
//            Place(englishName: PlaceIconConstant.Court.rawValue, type: "Tea House", location: "259 W 4th St, New York, NY 10014", phone: "354-243523", image: "c1",  imgs: ["c1", "c2", "c3"], iconLocation: (507,180)),
//            Place(englishName: PlaceIconConstant.Park.rawValue, type: "Austrian / Causual Drink", location: "326 Dekalb Ave, Brooklyn, NY 11205", phone: "453-333423", image: "test1", iconLocation: (261,207)),
//            Place(englishName: PlaceIconConstant.OldHouse.rawValue, type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "983-284334", image: "petiteoyster", iconLocation: (306,520)),
//            Place(englishName: PlaceIconConstant.BBall.rawValue, type: "Bakery", location: "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", phone: "232-434222", image: "forkeerestaurant", iconLocation: (32,832)),
//            Place(englishName: PlaceIconConstant.Plaza.rawValue, type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", phone: "234-834322", image: "posatelier.jpg", iconLocation: (294,1)),
//           ]
//    }
    
    let englishName: String, mandarinName: String, address: String, coordinate: (latitude: CGFloat, longitude: CGFloat), type: String, phone: String, openingTime: String, imgs: [String], englishStory: String, mandarinStory: String, mapImg: String,iconImg: String, website: String, iconLocation: (x: CGFloat, y: CGFloat)
    
    var isLiked: Bool
    
    init(dict: [String : Any]) {
        self.englishName = dict[BelizeCultureJSONConstant.englishName.rawValue] as? String ?? ""
        self.mandarinName = dict[BelizeCultureJSONConstant.mandarinName.rawValue] as? String ?? ""
        self.address = dict[BelizeCultureJSONConstant.address.rawValue] as? String ?? ""
        self.coordinate.latitude = dict[BelizeCultureJSONConstant.latitude.rawValue] as? CGFloat ?? 0
        self.coordinate.longitude = dict[BelizeCultureJSONConstant.longitude.rawValue] as? CGFloat ?? 0
        self.type = dict[BelizeCultureJSONConstant.type.rawValue] as? String ?? ""
        self.openingTime = dict[BelizeCultureJSONConstant.openingTime.rawValue] as? String ?? ""
        self.imgs = dict[BelizeCultureJSONConstant.imgs.rawValue] as? [String] ?? [String]()
        self.englishStory = dict[BelizeCultureJSONConstant.englishStory.rawValue] as? String ?? ""
        self.mandarinStory = dict[BelizeCultureJSONConstant.mandarinStory.rawValue] as? String ?? ""
        self.mapImg = dict[BelizeCultureJSONConstant.mapImg.rawValue] as? String ?? ""
        self.iconImg = dict[BelizeCultureJSONConstant.iconImg.rawValue] as? String ?? ""
        self.website = dict[BelizeCultureJSONConstant.website.rawValue] as? String ?? ""
        self.iconLocation.x = dict[BelizeCultureJSONConstant.iconLocationX.rawValue] as? CGFloat ?? 0
        self.iconLocation.y = dict[BelizeCultureJSONConstant.iconLocationY.rawValue] as? CGFloat ?? 0
        self.isLiked = dict[BelizeCultureJSONConstant.isLiked.rawValue] as? Bool ?? false
        self.phone = dict[BelizeCultureJSONConstant.phone.rawValue] as? String ?? ""
    }
    
    
    
    static func getPlaces() -> [Place]{
        var places = [Place]()
        parseJSON(fileName: "BelizeCulture") { (arr) in
            for dict in arr{
                let place = Place(dict: dict as! [String : Any])
                places.append(place)
            }
        }
        return places
    }
    
}

func parseJSON(fileName: String?, completion: (_ jsonArr: NSArray) -> ()) {
    let path = Bundle.main.path(forResource: fileName , ofType: "json")
    let url = URL(fileURLWithPath: path!)
    do {
        let data = try Data(contentsOf: url)
        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        let jsonArr = jsonData as! NSArray
        completion(jsonArr)
    } catch let error {
        print("Failed to access local JSON file",error)
    }
}
