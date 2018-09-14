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
    
    lazy var johnButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = PlaceButtonTag.Johns.rawValue
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        
        return btn
    }()
    
    lazy var hOCButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = PlaceButtonTag.HOC.rawValue
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var courtButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = PlaceButtonTag.Court.rawValue
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var parkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = PlaceButtonTag.Park.rawValue
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    
    lazy var oldHouseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = PlaceButtonTag.Eusey.rawValue
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var belizeSignButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = PlaceButtonTag.BelizeSign.rawValue
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    
    lazy var bBallButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = PlaceButtonTag.BBall.rawValue
        btn.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var plazaButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = PlaceButtonTag.Plaza.rawValue
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
        let dummyView = UIView()
        dummyView.frame = view.frame
        dummyView.backgroundColor = .clear
        view.addSubview(dummyView)
        
        sender.scaleAnimationNoRepeated(scaleX: 1.5, scaleY: 1.5)
        UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        
        if sender.tag == PlaceButtonTag.BelizeSign.rawValue{
            belizeSignDirectionView.removeFromSuperview()
        }
        
        
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
        
        if sender.tag == PlaceButtonTag.Johns.rawValue || sender.tag == PlaceButtonTag.HOC.rawValue || sender.tag == PlaceButtonTag.Eusey.rawValue {
            self.personImgView.moveAnimation(endView: sender, duration: 2.0) {
                self.setupPopView(buttonTag: sender.tag){
                    dummyView.removeFromSuperview()
                }
            }
        }else if sender.tag == PlaceButtonTag.Court.rawValue || sender.tag == PlaceButtonTag.Park.rawValue || sender.tag == PlaceButtonTag.Plaza.rawValue || sender.tag == PlaceButtonTag.BelizeSign.rawValue{
            self.personImgView.movAnimation(endView: sender, duration: 2.0, offsetX: -30, offSetY: sender.frame.height - 80) {
                self.setupPopView(buttonTag: sender.tag){
                    dummyView.removeFromSuperview()
                }
            }
        }else if sender.tag == PlaceButtonTag.BBall.rawValue{
            self.personImgView.movAnimation(endView: sender, duration: 2.0, offsetX: sender.frame.width - 60, offSetY: 0) {
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
   
    //for小英
    let belizeSignDirectionView = DirectionView()
    let personCaptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGoToCardButton()
        navigationController?.delegate = self
        
    }
}





extension MainViewController{
    
    
    
    fileprivate func setupViews(){
        setupMap()
        setupPlaceButtons()
        setupPersonImgView()
//        setupAllPlacesButtons()
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
    
    fileprivate func setupAllPlacesButtons(){
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
            allPlaceButtons.append(button)
        }
    }
    
    
    
    fileprivate func setupPlaceButtons(){
        let buttonHeight: CGFloat = 135
        let buttonWidth: CGFloat = 135
//        let allButtons = [johnButton, hOCButton, courtButton, parkButton, oldHouseButton, bBallButton, plazaButton, belizeSignButton]
        let allButtons = [hOCButton, courtButton, parkButton, oldHouseButton , bBallButton, plazaButton,belizeSignButton, johnButton,]
        for button in allButtons{
            view.addSubview(button)
            let buttonLocation = places[button.tag].iconLocation
            let buttonIconImg = places[button.tag].iconImg
            button.setImage(UIImage(named: buttonIconImg)?.withRenderingMode(.alwaysOriginal), for: .normal)
            let buttonName = places[button.tag].englishName
            button.frame = CGRect(x: buttonLocation.x , y: buttonLocation.y, width: buttonWidth, height: buttonHeight)
//                        button.backgroundColor = .red
                       // let nameLabel = UILabel(frame: CGRect(x: buttonLocation.x, y: buttonLocation.y + buttonHeight, width: buttonWidth, height: 30))
                       // nameLabel.text = " \(button.tag)"
                      //  view.addSubview(nameLabel)
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
        
        if buttonTag == PlaceButtonTag.Johns.rawValue || buttonTag == PlaceButtonTag.HOC.rawValue || buttonTag == PlaceButtonTag.Eusey.rawValue || buttonTag == PlaceButtonTag.BBall.rawValue{
            currentPopView.anchor(top: nil, bottom: self.personImgView.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: WidthConstant.popView.rawValue, height: HeightConstant.popView.rawValue)
            currentPopView.centerXAnchor.constraint(equalTo: self.personImgView.centerXAnchor, constant: 20).isActive = true
            print("currentPopView: ", currentPopView.bounds)
            currentPopView.layoutIfNeeded()
            currentPopView.applyArrowDialogAppearanceWithOrientation(frame: currentPopView.bounds, arrowOrientation: .down)
        } else if buttonTag == PlaceButtonTag.Court.rawValue || buttonTag == PlaceButtonTag.Park.rawValue || buttonTag == PlaceButtonTag.Plaza.rawValue || buttonTag == PlaceButtonTag.BelizeSign.rawValue{
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
    
    public func setupBelizeSignTrailView(){
        
        personCaptionLabel.textColor = .white
        personCaptionLabel.font = UIFont.boldSystemFont(ofSize: 32)
        personCaptionLabel.text = ClueConstant.personCaptionLabel.rawValue
        personCaptionLabel.numberOfLines = 0
        belizeSignTrailView.addSubview(personCaptionLabel)
        personCaptionLabel.frame = CGRect(x: 200, y: 530, width: 500, height: 200)
        belizeSignDirectionView.setValue(clue: ClueConstant.belizeCultureDirectionView.rawValue, arrow: "rightDirectionArrow")
        personCaptionLabel.alpha = 1.0
        belizeSignDirectionView.alpha = 0.0
        belizeSignTrailView.addSubview(belizeSignDirectionView)
        belizeSignDirectionView.frame = CGRect(x: 300, y: 30, width: 300, height: 300)
        UIView.animate(withDuration: 3.0, animations: {
            self.personCaptionLabel.alpha = 0.0
        }) { (finished) in
            if finished{
                UIView.animate(withDuration: 2.0, animations: {
                    self.belizeSignDirectionView.alpha = 1.0
                })
            }
        }
    }
    
    func setupFirstBelizeSignTrailView(){
        currentPopView?.removeFromSuperview()
        johnButton.removeFromSuperview()
        belizeSignTrailView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.insertSubview(belizeSignTrailView, belowSubview: belizeSignButton)
        belizeSignTrailView.fullAnchor(superView: view)
        view.insertSubview(johnButton, belowSubview: belizeSignTrailView)
        let buttonLocation = places[johnButton.tag].iconLocation
        let buttonIconImg = places[johnButton.tag].iconImg
        johnButton.setImage(UIImage(named: buttonIconImg)?.withRenderingMode(.alwaysOriginal), for: .normal)
        let buttonHeight: CGFloat = 180
        let buttonWidth: CGFloat = 180
        johnButton.frame = CGRect(x: buttonLocation.x , y: buttonLocation.y, width: buttonWidth, height: buttonHeight)
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
        //just for 小英
        self.setupFirstBelizeSignTrailView()
    }
    
    func removeTrailView() {
        belizeSignTrailView.removeFromSuperview()
    }
    
    func setupTrailView() {
        self.setupBelizeSignTrailView()
    }
    
    
    
}
