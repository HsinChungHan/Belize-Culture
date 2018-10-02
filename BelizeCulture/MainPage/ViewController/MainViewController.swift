//
//  MainViewController.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/7/30.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import Lottie
//為了讓Belize Sign Trail View只出現一次
var trailIsDone = false
var shouldBelizeSignTrailAppear = false

class MainViewController: UIViewController {
    
    
    let places = Place.getPlaces()
    var allPlaceButtons = [UIButton]()
    
    lazy var viewHeight = view.bounds.height
    lazy var viewWidth = view.bounds.height
    let slideLeftTransitionAnimator = SlideLeftTransitionAnimator()
    
    
    
    
    let customNavigationAnimationController = CustomNavigationAnimationController()
    let customInteractionController = CustomInteractionController()
    
    var listBeginningHeightAnchor: NSLayoutConstraint?
    var listAfterHeightAnchor: NSLayoutConstraint?
    var isSlided = false
    
    lazy var goToCardVCButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: IconsConstant.DisplayMode.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(goToCardVC), for: .touchUpInside)
        return btn
    }()
    
    @objc func goToCardVC(){
        let cardVC = CardViewController()
        navigationController?.pushViewController(cardVC, animated: true)
    }
    
    
    lazy var listButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: IconsConstant.Menu.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(showListView), for: .touchUpInside)
        return btn
    }()
    
    @objc func showListView(){
        if isSlided{
            isSlided = false
            listBeginningHeightAnchor?.isActive = true
            listAfterHeightAnchor?.isActive = false
        }else{
            isSlided = true
            listBeginningHeightAnchor?.isActive = false
            listAfterHeightAnchor?.isActive = true
        }
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    var currentPopView: PopInformationView?
    var currentButton: UIButton?
    lazy var mapImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "ShowRd")
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
        imgView.image = UIImage(named: "Guides")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var popView: PopInformationView = {
        let view = PopInformationView()
        view.backgroundColor = UIColor.backgroundRiceColor
        view.goToDetailVCDelegate = self
        return view
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
        let dummyView = UIView()
        dummyView.frame = view.frame
        dummyView.backgroundColor = .clear
        view.addSubview(dummyView)
        
        sender.scaleAnimationNoRepeated(scaleX: 1.5, scaleY: 1.5)
        UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        
        if sender.tag == PlaceButtonTag.Johns.rawValue{
            UIView.animate(withDuration: 0.5, animations: {
                self.directionView.alpha = 0.0
            }) { (finished) in
                if finished{
                    self.directionView.setValue(clue: ClueConstant.tapMoreToDetailView.rawValue, arrow: "leftDirectionArrow")
                    self.directionView.frame = CGRect(x: 420, y: 620, width: 300, height: 300)
                    UIView.animate(withDuration: 5.0, animations: {
                        self.directionView.alpha = 1.0
                    })
                }
            }
        }
        
        if sender.tag == PlaceButtonTag.Johns.rawValue || sender.tag == PlaceButtonTag.HOC.rawValue || sender.tag == PlaceButtonTag.EuseyHouse.rawValue || sender.tag == PlaceButtonTag.CockburnLaneHouse.rawValue {
            self.personImgView.moveAnimation(endView: sender, duration: 2.0) {
                self.setupPopView(buttonTag: sender.tag){
                    dummyView.removeFromSuperview()
                }
            }
        }else if sender.tag == PlaceButtonTag.Court.rawValue || sender.tag == PlaceButtonTag.MulePark.rawValue || sender.tag == PlaceButtonTag.PaslowPlaza.rawValue || sender.tag == PlaceButtonTag.BelizeWelcomeSign.rawValue || sender.tag == PlaceButtonTag.BattlefieldPark.rawValue{
            self.personImgView.movAnimation(endView: sender, duration: 2.0, offsetX: -30, offSetY: sender.frame.height - 80) {
                self.setupPopView(buttonTag: sender.tag){
                    dummyView.removeFromSuperview()
                }
            }
        }else if sender.tag == PlaceButtonTag.Yarborough.rawValue || sender.tag == PlaceButtonTag.WesleyChurch.rawValue || sender.tag == PlaceButtonTag.SwingBridge.rawValue{
            self.personImgView.movAnimation(endView: sender, duration: 2.0, offsetX: sender.frame.width - 60, offSetY: 30) {
                self.setupPopView(buttonTag: sender.tag){
                    dummyView.removeFromSuperview()
                }
            }
        }
        
    }
    
    lazy var whaleAnimationView: LOTAnimationView = {
        let animationView = LOTAnimationView()
        animationView.setAnimation(named: "whale")
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        animationView.animationSpeed = 1.0
        return animationView
    }()
    
    lazy var listView: ListView = {
        let lv = ListView()
        return lv
    }()
    
    
    lazy var trailView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var directionView: DirectionView = {
       let dv = DirectionView()
        
        return dv
    }()
    
    lazy var belizeSignTrailView: UIView = {
        let view = UIView()
        return view
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupViews()
//        setupGoToCardButton()
        navigationController?.delegate = self
    }
}





extension MainViewController{
    public func setupViews(){
        setupMap()
        setupAllPlacesButtons()
        setupPersonImgView()
        setupGoToCardButton()
        
        setupListButton()
        setupListView()
//        setupWhaleAnimationView()
    }
    
    fileprivate func setupMap() {
        view.addSubview(mapImgView)
        mapImgView.fullAnchor(superView: view)
    }
    
    fileprivate func setupPersonImgView(){
        view.addSubview(personImgView)
        personImgView.frame = CGRect(x: UIScreen.main.bounds.width - 100, y: 40, width: 80, height: 80)
    }
    
    public func setupAllPlacesButtons(){
        for index in 0 ..< places.count{
            let button = UIButton(type: .system)
            button.tag = index
            button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
            button.imageView?.contentMode = .scaleAspectFit
            view.addSubview(button)
            let buttonLocation = places[button.tag].iconLocation
            let buttonIconImg = places[button.tag].iconImg
            button.setImage(UIImage(named: buttonIconImg)?.withRenderingMode(.alwaysOriginal), for: .normal)
            let buttonName = places[button.tag].englishName
            let buttonHeight: CGFloat = 135
            let buttonWidth: CGFloat = 135
            button.frame = CGRect(x: buttonLocation.x , y: buttonLocation.y, width: buttonWidth, height: buttonHeight)
//            let nameLabel = UILabel()
//            nameLabel.text = buttonName
//            view.addSubview(nameLabel)
//            nameLabel.frame = CGRect(x: buttonLocation.x , y: buttonLocation.y + 140, width: buttonWidth, height: 20)
//            nameLabel.textColor = .white
            allPlaceButtons.append(button)
        }
    }
    
    
    fileprivate func setupGoToCardButton(){
        view.addSubview(goToCardVCButton)
        goToCardVCButton.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: nil
            , topPadding: 20, bottomPadding: 0, leftPadding: 20, rightPadding: 0, width: 80, height: 80)
    }
    
    fileprivate func setupListButton(){
        view.addSubview(listButton)
        listButton.anchor(top: goToCardVCButton.bottomAnchor, bottom: nil, left: goToCardVCButton.leftAnchor, right: goToCardVCButton.rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 80)
    }
    
    fileprivate func generateMoveAnimation(targetView: UIView, startView: UIView, endView: UIView, startAndEndSuperView: UIView, duration: CFTimeInterval){
        let pathView = PathView()
        pathView.alpha = 0
        pathView.frame = view.frame
        view.addSubview(pathView)
        pathView.customPath(startView: startView, endView: endView, startAndEndSuperView: startAndEndSuperView, lineWidth: 2.0)
        targetView.moveAnimation(pathView: pathView, duration: duration)
    }
    
    fileprivate func setupWhaleAnimationView() {
        view.addSubview(whaleAnimationView)
        whaleAnimationView.anchor(top: nil, bottom: view.bottomAnchor, left: nil, right: view.rightAnchor, topPadding: 0, bottomPadding: 80, leftPadding: 0, rightPadding: 60, width: 200, height: 200)
        whaleAnimationView.play()
    }
    
    fileprivate func setupListViewPosition(){
        listBeginningHeightAnchor = listView.heightAnchor.constraint(equalToConstant: 0)
        listAfterHeightAnchor = listView.heightAnchor.constraint(equalToConstant: 200)
    }
    
    fileprivate func setupListView(){
        setupListViewPosition()
        view.addSubview(listView)
        listView.anchor(top: listButton.bottomAnchor, bottom: nil, left: listButton.leftAnchor, right: listButton.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        listBeginningHeightAnchor?.isActive = true
    }
    fileprivate func setupPopView(buttonTag: Int, completion: () -> ()){
        self.currentPopView = PopInformationView()
        guard let currentPopView = self.currentPopView else {return}
        currentPopView.goToDetailVCDelegate = self
        currentPopView.setupValues(place: self.places[buttonTag], senderTag: buttonTag)
        self.view.addSubview(currentPopView)
        currentPopView.goToDetailVCDelegate = self
        
        if buttonTag == PlaceButtonTag.Johns.rawValue || buttonTag == PlaceButtonTag.HOC.rawValue || buttonTag == PlaceButtonTag.EuseyHouse.rawValue || buttonTag == PlaceButtonTag.CockburnLaneHouse.rawValue || buttonTag == PlaceButtonTag.Yarborough.rawValue || buttonTag == PlaceButtonTag.WesleyChurch.rawValue{
            currentPopView.anchor(top: nil, bottom: self.personImgView.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: WidthConstant.popView.rawValue, height: HeightConstant.popView.rawValue)
            currentPopView.centerXAnchor.constraint(equalTo: self.personImgView.centerXAnchor, constant: 20).isActive = true
            print("currentPopView: ", currentPopView.bounds)
            currentPopView.layoutIfNeeded()
            currentPopView.applyArrowDialogAppearanceWithOrientation(frame: currentPopView.bounds, arrowOrientation: .down)
        } else if buttonTag == PlaceButtonTag.Court.rawValue || buttonTag == PlaceButtonTag.MulePark.rawValue || buttonTag == PlaceButtonTag.PaslowPlaza.rawValue || buttonTag == PlaceButtonTag.BelizeWelcomeSign.rawValue || buttonTag == PlaceButtonTag.SwingBridge.rawValue || buttonTag == PlaceButtonTag.BattlefieldPark.rawValue{
            currentPopView.anchor(top: self.personImgView.bottomAnchor, bottom: nil, left: nil, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: WidthConstant.popView.rawValue, height: HeightConstant.popView.rawValue)
            currentPopView.centerXAnchor.constraint(equalTo: self.personImgView.centerXAnchor, constant: 20).isActive = true
            currentPopView.layoutIfNeeded()
            currentPopView.applyArrowDialogAppearanceWithOrientation(frame: currentPopView.bounds, arrowOrientation: .up)
        }
        currentPopView.setCorner(radius: 10)
        completion()
    }
    
    public func setupTrailView(belowSubview: UIButton){
        trailView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.insertSubview(trailView, belowSubview: belowSubview)
        trailView.fullAnchor(superView: view)
        trailView.addSubview(directionView)
        directionView.frame = CGRect(x: 60, y: 750, width: 300, height: 300)
    }
}























extension MainViewController: GoToDetailVCDelegate{
    func goToDetailVC(senderTag: Int) {
       
        let detailVC = DetailViewController()
        detailVC.delegate = self
        detailVC.place = places[senderTag]
        let naviVC = UINavigationController(rootViewController: detailVC)
        naviVC.transitioningDelegate = slideLeftTransitionAnimator
        naviVC.isNavigationBarHidden = true
        present(naviVC, animated: true){
             self.trailView.removeFromSuperview()
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


extension MainViewController: DetailViewControllerDelegate{
    func setupDummyTrailView() {
    }
    
    func removeTrailView() {
        
    }
    
    func setupTrailView() {
    }
    
    
    
}
