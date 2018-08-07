//
//  PopInformationView.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/7/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

protocol GoToDetailVCDelegate{
    func goToDetailVC(senderTag: Int)
}

class PopInformationView: BasicView {
    var place: Place?{
        didSet{
            guard let place = place else {return}
            imgs = place.imgs
            titleLabe.text = place.name
            pageView.numberOfPages = imgs.count
            setupCurrentIndex()
        }
    }
    
    var senderTag: Int?
    
    var goToDetailVCDelegate: GoToDetailVCDelegate?
    var imgs = ["test1","test2","test3","test4"]
    let bannerContentCell = "BannerContentCell"
    var currentIndexPath: IndexPath?
    var timer: Timer?
    var oldOffset: CGFloat = 0.0

    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .red
        cv.delegate = self
        cv.dataSource = self
        cv.register(BannerContentCell.self, forCellWithReuseIdentifier: bannerContentCell)
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var pageView: UIPageControl = {
        let pv = UIPageControl()
        pv.currentPage = 0
        pv.pageIndicatorTintColor = .gray
        pv.currentPageIndicatorTintColor = .white
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    
    
    lazy var detailButton: UIButton = {
       let btn = UIButton(type: .system)
        btn.setTitle(">", for: .normal)
        btn.titleLabel?.textAlignment = .right
        btn.setTitleColor(UIColor.backgroundRiceColor, for: .normal)
        btn.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        return btn
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.classicDarkGreen.withAlphaComponent(0.7)
        return view
    }()
    
    lazy var titleLabe: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.backgroundRiceColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "MC Hot Dog"
        label.textAlignment = .left
        return label
    }()
    
    
    @objc func goToDetail(){
//        removeTimer()
        guard let senderTage = senderTag else {return}
        goToDetailVCDelegate?.goToDetailVC(senderTag: senderTage)
    }
   
    
    
    override func setupViews() {
        setupCollectionView()
        setupBottomView()
        addTimer()
    }
}

extension PopInformationView{
    
    
    fileprivate func setupCollectionView(){
        addSubview(collectionView)
        collectionView.fullAnchor(superView: self)
        collectionView.layoutIfNeeded()
        
        
    }
    
    fileprivate func setupCurrentIndex(){
        currentIndexPath = IndexPath(item: imgs.count, section: 0)
        guard let currentIndexPath = currentIndexPath else {return}
        collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    fileprivate func setupBottomView(){
        addSubview(bottomView)
        bottomView.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 100)
        bottomView.addSubview(pageView)
        pageView.anchor(top: nil, bottom: bottomView.bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: 100, height: 40)
        pageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomView.addSubview(detailButton)
        detailButton.anchor(top: nil, bottom: bottomView.bottomAnchor, left: nil, right: rightAnchor, topPadding: 0, bottomPadding: 30, leftPadding: 0, rightPadding: 5, width: 80, height: 40)
        bottomView.addSubview(titleLabe)
        titleLabe.anchor(top: bottomView.topAnchor, bottom: nil, left: bottomView.leftAnchor, right: nil, topPadding: 20, bottomPadding: 0, leftPadding: 20, rightPadding: 0, width: 200, height: 30)
        
//        let bottomViewLayer = CAGradientLayer()
//        bottomViewLayer.setGradientLayer(view: bottomView, colors: [UIColor.classicDarkGreen.withAlphaComponent(0.8), UIColor.lightGray.withAlphaComponent(0.5)])
        print("bottomView.frame: ", bottomView.frame)
        
    }
    
    
    
    
    func addTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { [weak self](_) in
            guard let currentIndexPath = self?.currentIndexPath else {return}
            self?.showImage(isNext: true, indexPath: currentIndexPath)
        })
        guard let timer = timer else {return}
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func showImage(isNext: Bool, indexPath: IndexPath) {
        var index: Int
        if isNext{
            index = indexPath.item + 1
        }else{
            index = indexPath.item - 1
        }
        currentIndexPath = IndexPath(item: index, section: 0)
        showPageViewAndCollectionView(indexPath: currentIndexPath!, imgStrsPath: imgs)
    }
    
    func showPageViewAndCollectionView(indexPath: IndexPath, imgStrsPath: [String]) {
        pageView.currentPage = indexPath.item % imgStrsPath.count
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally , animated: true)
    }
    
    func reloadImage(indexPath: IndexPath, imgStrsPath: [String]){
        if indexPath.item == imgStrsPath.count * 2 - 1{
            currentIndexPath = IndexPath(item: imgStrsPath.count - 1, section: 0)
            collectionView.scrollToItem(at: currentIndexPath!, at: .centeredHorizontally, animated: false)
        }else if indexPath.item == 0{
            currentIndexPath = IndexPath(item: imgStrsPath.count, section: 0)
            collectionView.scrollToItem(at: currentIndexPath!, at: .centeredHorizontally, animated: false)
        }
    }
    
    public func setupValues(place: Place, senderTag: Int){
        self.place = place
        self.senderTag = senderTag
    }
    
}


