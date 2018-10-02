//
//  MainTabBarController.swift
//  Instagram
//
//  Created by 辛忠翰 on 12/01/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    
    func setupViewController(){
        
        //vieController tab
        
        let mainVC = MainViewController()
        mainVC.setupViews()
        mainVC.setupTrailView(belowSubview: mainVC.allPlaceButtons[PlaceButtonTag.Johns.rawValue])
        let mainNaviVC = templateNaviViewController(rootViewController: mainVC, unselectedImage: "traffic-lights", selectedImage: "traffic-lights", title: "Search")
        
        //search tab
        let ICDFIntroductionVC = ICDFIntroductionViewController()
        let ICDFIntroductionNaviVC = templateNaviViewController(rootViewController: ICDFIntroductionVC, unselectedImage: "traffic-lights", selectedImage: "traffic-lights", title: "ICDF")
        
        viewControllers = [
                           mainNaviVC,
                           ICDFIntroductionNaviVC,
                           ]
        
        //因為icom預設在tab bar中，是中間偏上，所以我們要用程式碼的方式調整位置
        //modify tab bar item inset
        //需在把所有naviVC塞到viewControllers後再行調整
        
//        guard let items = tabBar.items else {return}
//        for item in items{
//            //讓item中的image往下一點，到正中央的位置
//            //其中buttom調整為-4是因為，要讓整張圖片可以往下4，比例才不會跑掉
//            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
//        }
        
    }
    
    fileprivate func templateNaviViewController(rootViewController: UIViewController, unselectedImage: String, selectedImage: String, title: String) -> UINavigationController{
        let naviVC = UINavigationController(rootViewController: rootViewController)
        naviVC.tabBarItem.image = UIImage(named: unselectedImage)?.withRenderingMode(.alwaysOriginal)
        naviVC.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        naviVC.tabBarItem.title = title
        naviVC.isNavigationBarHidden = true
        return naviVC
    }
}






