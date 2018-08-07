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
    
    let type: String, name: String, location: String, image: String, phone: String, time: String
    let imgs:[String], mapImg: String
    var isLiked: Bool
    let iconLocation: (x: CGFloat, y: CGFloat)
    
    
    init(name: String, type: String, location: String, phone : String, image: String, imgs: [String] = ["test1", "test2", "test3", "test4"], time: String = "10:00 ~ 18:00", mapImg: String = "mapImg", isLiked: Bool = false, iconLocation:(x: CGFloat, y: CGFloat) = (0,0) ) {
        
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.phone = phone
        self.imgs = imgs
        self.time = time
        self.mapImg = mapImg
        self.isLiked = isLiked
        self.iconLocation = iconLocation
    }
    
    static func oneTestPlace() -> Place{
        return Place(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "110 St Marks Pl New York, NY 10009", phone: "232-923423", image: "cafedeadend", imgs: ["a1", "a2", "a3", "a4"])
        
    }
    
    static func allPlaces() -> [Place]{
        return [
            Place(name: PlaceIconConstant.Johns.rawValue, type: "Coffee & Tea Shop", location: "110 St Marks Pl New York, NY 10009", phone: "232-923423", image: "a1", imgs: ["a1", "a2", "a3", "a4"], iconLocation: (248,727)),
            Place(name: PlaceIconConstant.HOC.rawValue, type: "Cafe", location: "524 Ct St, Brooklyn, NY 11231", phone: "348-233423", image: "b1", imgs: ["b1", "b2", "b3"], iconLocation: (518,636)),
            Place(name: PlaceIconConstant.Court.rawValue, type: "Tea House", location: "259 W 4th St, New York, NY 10014", phone: "354-243523", image: "c1",  imgs: ["c1", "c2", "c3"], iconLocation: (507,180)),
            Place(name: PlaceIconConstant.Park.rawValue, type: "Austrian / Causual Drink", location: "326 Dekalb Ave, Brooklyn, NY 11205", phone: "453-333423", image: "test1", iconLocation: (261,207)),
            Place(name: PlaceIconConstant.OldHouse.rawValue, type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "983-284334", image: "petiteoyster", iconLocation: (306,520)),
            Place(name: PlaceIconConstant.BBall.rawValue, type: "Bakery", location: "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", phone: "232-434222", image: "forkeerestaurant", iconLocation: (32,832)),
            Place(name: PlaceIconConstant.Plaza.rawValue, type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", phone: "234-834322", image: "posatelier.jpg", iconLocation: (294,1)),
            Place(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", phone: "982-434343", image: "bourkestreetbakery"),
            Place(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", phone: "734-232323", image: "haighschocolate"),
//            Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", phone: "872-734343", image: "palominoespresso.jpg", isVisited: false),
//            Restaurant(name: "Upstate", type: "American", location: "95 1st Ave New York, NY 10003", phone: "343-233221", image: "upstate.jpg", isVisited: false),
//            Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", phone: "985-723623", image: "traif.jpg", isVisited: false),
//            Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", phone: "455-232345", image: "grahamavenuemeats.jpg", isVisited: false),
//            Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", phone: "434-232322", image: "wafflewolf.jpg", isVisited: false),
//            Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave Brooklyn, NY 11222", phone: "343-234553", image: "fiveleaves.jpg", isVisited: false),
//            Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", phone: "342-455433", image: "cafelore.jpg", isVisited: false),
//            Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", phone: "643-332323", image: "confessional.jpg", isVisited: false),
//            Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", phone: "542-343434", image: "barrafina.jpg", isVisited: false),
//            Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", phone: "722-232323", image: "donostia.jpg", isVisited: false),
//            Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", phone: "343-988834", image: "royaloak.jpg", isVisited: false),
//            Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", phone: "432-344050", image: "caskpubkitchen.jpg", isVisited: false)
            
        ]
    }
}
