//
//  DetailViewController.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/7/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    func setupTrailView()
    func setupDummyTrailView()
    func removeTrailView()
}



class DetailViewController: UIViewController {
    var delegate: DetailViewControllerDelegate?
    
    var titleRightAnchorConstraint: NSLayoutConstraint?
    let slideLeftTransitionAnimator = SlideLeftTransitionAnimator()
    var segmentedContolViewHeight: CGFloat = 0{
        didSet{
            setupTableViewBackgroundView(view: tableBackgroundView, headerView: tableHeaderView, backGroundViewHeight: HeightConstant.plcacImgView.rawValue)
        }
    }
    
    var isStory = true
    let informationCellId = "InformationCellID"
    let mapInformationCellId = "MapInformationCellID"
    let storyCellId = "StoryCellID"
    let defaultCellId = "DefaultCellID"
    
    var informationCellOriginalHeight = HeightConstant.informationCell.rawValue
    var informationCellLaterHeight = HeightConstant.informationCell.rawValue + 600

    
    
    var place: Place?{
        didSet{
            guard let place = place else {return}
//            tableBackgroundView.image = UIImage(named: place.image)
            tableBackgroundView.setImgValue(img: place.imgs[0])
            titleLabel.text = place.englishName
            tableView.reloadData()
        }
    }
    
    
    var isScroll = false
    
    lazy var dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: IconsConstant.back.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(dismissDetailVC), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        return btn
    }()
    
    @objc func dismissDetailVC(){
        
        if !trailIsDone{
            shouldBelizeSignTrailAppear = true
            delegate?.setupDummyTrailView()
            dismiss(animated: true){
                self.delegate?.setupTrailView()
            }
            
        }else{
            delegate?.removeTrailView()
            shouldBelizeSignTrailAppear = false
            dismiss(animated: true)
        }
        trailIsDone = true
       
    }
    
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()

    let tableBackgroundView: TableBackgroundView = {
        let imv = TableBackgroundView()
        return imv
    }()
    
    
    let tableHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
        
    }()
    
    
    lazy var sectionHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        return view
    }()
    
    lazy var segmentedContolView: SegmentedControlView = {
        let scv = SegmentedControlView()
        scv.delegate = self
        scv.setupValues(values: [SegmentedControlConstant.story.rawValue, SegmentedControlConstant.information.rawValue])
        return scv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "M.C Hot Dog"
        label.textAlignment = .center
        return label
    }()
    
    let directionView: DirectionView = {
       let dv = DirectionView()
        dv.setValue(clue: "", arrow: "finger")
        return dv
    }()
    
    let tapInformationDirectionView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "fingerTap")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundRiceColor
        registerCell()
        setupTableView()
        setupTableViewStyle()
        setupDismissButton()
        setupDirectionView()
    }
    
    
}


extension DetailViewController{
    fileprivate func setupDismissButton(){
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 60, height: 60)
    }
    
    fileprivate func setupTableViewStyle(){
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
//        tableView.separatorColor = .white
        //讓沒有row的地方，直接就是底色
        let blankView = UIView(frame: .zero)
        tableView.tableFooterView = blankView
        
    }
    
    fileprivate func registerCell(){
        tableView.register(InformationTableViewCell.self, forCellReuseIdentifier: informationCellId)
        tableView.register(MapInformationTableViewCell.self, forCellReuseIdentifier: mapInformationCellId)
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: storyCellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellId)
    }
    
    fileprivate func setupTableView(){
        view.addSubview(tableView)
        tableView.fullAnchor(superView: view)
    }
    
    fileprivate func setupTableViewBackgroundView(view: UIView, headerView: UIView, backGroundViewHeight: CGFloat){
        tableView.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: backGroundViewHeight))
        tableView.backgroundView?.addSubview(view)
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: backGroundViewHeight)
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: backGroundViewHeight - segmentedContolViewHeight)
//        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: backGroundViewHeight)
        tableView.tableHeaderView = headerView
    }
    
    fileprivate func setupSectionHeaderView(){
        sectionHeaderView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: sectionHeaderView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: sectionHeaderView.topAnchor, constant: 10).isActive = true
        titleLabel.sizeToFit()
        sectionHeaderView.addSubview(segmentedContolView)
        segmentedContolView.anchor(top: titleLabel.bottomAnchor, bottom: nil, left: sectionHeaderView.leftAnchor, right: sectionHeaderView.rightAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 15, rightPadding: 15, width: 0, height: 0)
        sectionHeaderView.layoutIfNeeded()
        segmentedContolViewHeight = segmentedContolView.frame.height
        
    }
    
    func setupDirectionView(){
        view.addSubview(directionView)
        directionView.frame = CGRect(x: 20, y: 550, width: 100, height: 100)
        directionView.directionArrowImgView.moveAnimation(dy: -330) {
        }
    }
}



extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isStory{
            return RowNumberConstant.story.rawValue
        }
        return RowNumberConstant.story.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.item
        var cell: UITableViewCell
        var cellId: String
        switch row{
        case 0:
            if isStory{
                cellId = storyCellId
                
            }else{
                cellId = informationCellId
            }
        case 1: cellId = mapInformationCellId
        default: cellId = defaultCellId
        }
        cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if cellId == informationCellId{
           let cell = cell as! InformationTableViewCell
            cell.place = place
            cell.delegate = self
           return cell
        }else if cellId == mapInformationCellId{
           let cell = cell as! MapInformationTableViewCell
            cell.place = place
            cell.goToMapVCDelegate = self
        }else if cellId == storyCellId{
            let cell = cell as! StoryTableViewCell
            cell.setupValues(place: place)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == IndexPathConstant.mapCell.rawValue{
            let mapVC = MapViewController()
            guard let place = place else {return}
            mapVC.setupValues(place: place)
            let naviVC = UINavigationController(rootViewController: mapVC)
            naviVC.transitioningDelegate = slideLeftTransitionAnimator
            naviVC.isNavigationBarHidden = true
            self.present(naviVC, animated: true, completion: nil)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == IndexPathConstant.informationCell.rawValue{
            if isStory{
                return HeightConstant.storyCell.rawValue
            }
            
            return  informationCellOriginalHeight

            
        }else if indexPath.item == IndexPathConstant.mapCell.rawValue{
            if isStory{
                 return 0
            }
            return HeightConstant.mapCell.rawValue
           
        }
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            setupSectionHeaderView()
            return sectionHeaderView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 100
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        directionView.removeFromSuperview()
        let offsetY = scrollView.contentOffset.y
        print("offsetY: ", offsetY)
        sectionHeaderView.backgroundColor = UIColor.classicDarkGreen.withAlphaComponent(offsetY/HeightConstant.plcacImgView.rawValue)
        
        if offsetY < 0{
           
            tableBackgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - offsetY, height: HeightConstant.plcacImgView.rawValue - offsetY)
//            guard let tableHeaderViewCenter = tableView.tableHeaderView?.center else {return}
//            tableBackgroundView.center = tableHeaderViewCenter
            
        }else {
//           titleLabel.rightAnchor.constraint(equalTo: sectionHeaderView.rightAnchor, constant: offsetY).isActive = true
//            titleLabel.frame.origin.x = titleLabel.frame.origin.x + offsetY/2
        }
        
        
        
        
    }
    
   
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !isScroll{
            sectionHeaderView.addSubview(tapInformationDirectionView)
            tapInformationDirectionView.frame = CGRect(x: 700, y:  10, width: 100, height: 100)
            tapInformationDirectionView.alpha = 0.0
            UIView.animate(withDuration: 1.0, animations: {
                self.tapInformationDirectionView.alpha = 1.0
            }) { (_) in
                
            }
        }else {
            tapInformationDirectionView.removeFromSuperview()
        }
       
        

        
        print("x = ", sectionHeaderView.frame.minX)
        print("y = ", sectionHeaderView.frame.minY)
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
       
//            directionView.setValue(clue: ClueConstant.tapInformationSegmentControl.rawValue, arrow: "fingerTap")
//            sectionHeaderView.addSubview(directionView)
//            directionView.alpha = 0.0
//            directionView.frame = CGRect(x: 700, y: 350, width: 100, height: 100)
//            UIView.animate(withDuration: 1.0, animations: {
//                self.directionView.alpha = 1.0
//            }) { (_) in
//
//            }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        directionView.setValue(clue: "", arrow: "fingerTap")
        segmentedContolView.addSubview(directionView)
        directionView.alpha = 0.0
        directionView.frame = CGRect(x: 700, y: 0, width: 10, height: 10)
        UIView.animate(withDuration: 1.0, animations: {
            self.directionView.alpha = 1.0
        }) { (_) in

        }
        print("spring!!!!")
    }
}


extension DetailViewController: ChangeSegmentedContolValueProtocol{
    func changeCurrentValue(isStory: Bool) {
        self.isStory = isStory
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.reloadRows(at: [indexPath], with: .fade)
         isScroll = true
        tapInformationDirectionView.removeFromSuperview()
    }
}

extension DetailViewController: GoToMapVCDelegate{
    func goToMapVC() {
        let mapVC = MapViewController()
        guard let place = place else {return}
        mapVC.setupValues(place: place)
        let naviVC = UINavigationController(rootViewController: mapVC)
        naviVC.transitioningDelegate = slideLeftTransitionAnimator
        naviVC.isNavigationBarHidden = true
        self.present(naviVC, animated: true, completion: nil)
    }
    
    
}

extension DetailViewController: InformationTableViewCellDelegate{
    func showWebView() {
//        let newHeight = informationCellHeight + 300
        informationCellOriginalHeight = informationCellLaterHeight
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.reloadRows(at: [indexPath], with: .fade)
        tableView.scrollToRow(at: indexPath, at: .bottom , animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? InformationTableViewCell
        cell?.webSiteView.websiteViewIsShowed()
        
    }
    
}
