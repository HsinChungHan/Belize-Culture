//
//  MainViewController.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/7/30.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let places = Place.allPlaces()
    lazy var viewHeight = view.bounds.height
    lazy var viewWidth = view.bounds.height
    let slideLeftTransitionAnimator = SlideLeftTransitionAnimator()
    
    
    
    
    let customNavigationAnimationController = CustomNavigationAnimationController()
    let customInteractionController = CustomInteractionController()

    lazy var goToCardVCButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "list")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.imageView?.clipsToBounds = true
        btn.addTarget(self, action: #selector(goToCardVC), for: .touchUpInside)
        return btn
    }()
    
    @objc func goToCardVC(){
        let cardVC = CardViewController()
        navigationController?.pushViewController(cardVC, animated: true)
        
    }
    
    var currentPopView: PopInformationView?
    var currentButton: UIButton?
    lazy var mapImgView: UIImageView = {
       let imv = UIImageView()
        imv.image = UIImage(named: "map")
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPopView))
        imv.addGestureRecognizer(tapGestureRecognizer)
        return imv
    }()
    
    @objc func dismissPopView(){
        guard let currentPopView = currentPopView, let currentButton = currentButton else {
            return
        }
        currentButton.scaleAnimationRepeated(scaleX: 1.0, scaleY: 1.0)
        currentPopView.removeFromSuperview()
        self.currentPopView = nil
        self.currentButton = nil
    }
    
    lazy var personImgView: UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(named: "ninja")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var popView: PopInformationView = {
        let view = PopInformationView()
        view.backgroundColor = UIColor.backgroundRiceColor
        view.goToDetailVCDelegate = self
        return view
    }()
    
    lazy var johnButton: UIButton = {
       let btn = UIButton(type: .system)
        btn.tag = 0
        btn.setImage(UIImage(named: PlaceIconConstant.Johns.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tag = 0
        return btn
    }()
    
    lazy var hOCButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 1
        btn.setImage(UIImage(named: PlaceIconConstant.HOC.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var courtButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 2
        btn.setImage(UIImage(named: PlaceIconConstant.Court.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var parkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 3
        btn.setImage(UIImage(named: PlaceIconConstant.Park.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    
    lazy var oldHouseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 4
        btn.setImage(UIImage(named: PlaceIconConstant.OldHouse.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var bBallButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 5
        btn.setImage(UIImage(named: PlaceIconConstant.BBall.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var plazaButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 6
        btn.setImage(UIImage(named: PlaceIconConstant.Plaza.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    
    
    @objc func handleTap(sender: UIButton){
        if currentButton == sender{
            return
        }
        if currentPopView != nil || currentButton != nil{
            currentPopView?.removeFromSuperview()
            currentButton?.scaleAnimationNoRepeated(scaleX: 1.0, scaleY: 1.0)
            currentPopView = nil
            currentButton = nil

        }
        currentButton = sender
        sender.scaleAnimationNoRepeated(scaleX: 1.5, scaleY: 1.5)
        UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        if sender.tag == 0 || sender.tag == 1 || sender.tag == 4{
            self.personImgView.moveAnimation(endView: sender, duration: 2.0) {
                self.setupPopView(buttonTag: sender.tag)
            }
        }else if sender.tag == 2 || sender.tag == 3 || sender.tag == 6{
            self.personImgView.movAnimation(endView: sender, duration: 2.0, offsetX: 0, offSetY: sender.frame.height) {
                self.setupPopView(buttonTag: sender.tag)
            }
        }else if sender.tag == 5{
            self.personImgView.movAnimation(endView: sender, duration: 2.0, offsetX: sender.frame.width, offSetY: 0) {
                self.setupPopView(buttonTag: sender.tag)
            }
        }
    }
    
    fileprivate func setupPopView(buttonTag: Int){
        self.currentPopView = PopInformationView()
        guard let currentPopView = self.currentPopView else {return}
        currentPopView.goToDetailVCDelegate = self
        currentPopView.setupValues(place: self.places[buttonTag], senderTag: buttonTag)
        self.view.addSubview(currentPopView)
        currentPopView.goToDetailVCDelegate = self
        
        if buttonTag == 0 || buttonTag == 1 || buttonTag == 4 || buttonTag == 5{
            currentPopView.anchor(top: nil, bottom: self.personImgView.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: WidthConstant.popView.rawValue, height: HeightConstant.popView.rawValue)
            currentPopView.centerXAnchor.constraint(equalTo: self.personImgView.centerXAnchor, constant: 20).isActive = true
            print("currentPopView: ", currentPopView.bounds)
            currentPopView.layoutIfNeeded()
            currentPopView.applyArrowDialogAppearanceWithOrientation(frame: currentPopView.bounds, arrowOrientation: .down)
        } else if buttonTag == 2 || buttonTag == 3 || buttonTag == 6{
            currentPopView.anchor(top: self.personImgView.bottomAnchor, bottom: nil, left: nil, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: WidthConstant.popView.rawValue, height: HeightConstant.popView.rawValue)
            currentPopView.centerXAnchor.constraint(equalTo: self.personImgView.centerXAnchor, constant: 20).isActive = true
            currentPopView.layoutIfNeeded()
            currentPopView.applyArrowDialogAppearanceWithOrientation(frame: currentPopView.bounds, arrowOrientation: .up)
        }
        currentPopView.setCorner(radius: 10)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGoToCardButton()
        navigationController?.delegate = self
        print("UIScreen.main.bounds.width: ",UIScreen.main.bounds.width)
        print("UIScreen.main.bounds.height: ",UIScreen.main.bounds.height)
    }
    
   
}





extension MainViewController{
    fileprivate func setupViews(){
        setupMap()
//        setupAllPlacesButton()
        setupPlaceButtons()
        setupPersonImgView()
    }
    
    fileprivate func setupMap() {
        view.addSubview(mapImgView)
        mapImgView.fullAnchor(superView: view)
    }
    
    fileprivate func setupPersonImgView(){
        view.addSubview(personImgView)
        personImgView.frame = CGRect(x: UIScreen.main.bounds.width - 100, y: 20, width: 50, height: 50)
    }
    
    fileprivate func setupPlaceButtons(){
        let buttonHeight: CGFloat = 135
        let buttonWidth: CGFloat = 135
        let allButtons = [johnButton, hOCButton, courtButton, parkButton, oldHouseButton, bBallButton, plazaButton]
        for button in allButtons{
            view.insertSubview(button, aboveSubview: mapImgView)
            let buttonLocation = places[button.tag].iconLocation
            let buttonName = places[button.tag].name
            button.frame = CGRect(x: buttonLocation.x , y: buttonLocation.y, width: buttonWidth, height: buttonHeight)
//            button.backgroundColor = .red
//            let nameLabel = UILabel(frame: CGRect(x: buttonLocation.x, y: buttonLocation.y + buttonHeight, width: buttonWidth, height: 30))
//            nameLabel.text = "\(buttonName), \(button.tag)"
//            nameLabel.textColor = UIColor.white
//            nameLabel.font = UIFont.italicSystemFont(ofSize: 25)
//            nameLabel.textAlignment = .center
//            view.addSubview(nameLabel)
        }
    }
    
    
    fileprivate func setupGoToCardButton(){
        view.insertSubview(goToCardVCButton, aboveSubview: mapImgView)
        goToCardVCButton.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, topPadding: 20, bottomPadding: 0, leftPadding: 20, rightPadding: 0, width: 80, height: 80)
    }
   
    
    fileprivate func generateMoveAnimation(targetView: UIView, startView: UIView, endView: UIView, startAndEndSuperView: UIView, duration: CFTimeInterval){
        let pathView = PathView()
        pathView.alpha = 0
        pathView.frame = view.frame
        view.addSubview(pathView)
        pathView.customPath(startView: startView, endView: endView, startAndEndSuperView: startAndEndSuperView, lineWidth: 2.0)
        targetView.moveAnimation(pathView: pathView, duration: duration)
    }
}


extension MainViewController: GoToDetailVCDelegate{
    func goToDetailVC(senderTag: Int) {
        let detailVC = DetailViewController()
        detailVC.place = places[senderTag]
        let naviVC = UINavigationController(rootViewController: detailVC)
        naviVC.transitioningDelegate = slideLeftTransitionAnimator
        naviVC.isNavigationBarHidden = true
        present(naviVC, animated: true) {
        }
    }
}


extension MainViewController: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            customInteractionController.attachToViewController(viewController: toVC)
        }
        customNavigationAnimationController.reverse = operation == .pop
        return customNavigationAnimationController
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return customInteractionController.transitionInProgress ? customInteractionController : nil
    }
}
