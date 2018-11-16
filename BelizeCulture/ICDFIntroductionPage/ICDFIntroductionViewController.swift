//
//  ICDFIntroductionViewController.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/9/30.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ICDFIntroductionViewController: UIViewController {
    fileprivate let paragraphsIntroduction = ICDFIntrodutionParagraph.getAllParagraphs()

    fileprivate let paragraphCellID = "ParagraphCellID"
    fileprivate let finalParagraphCellID = "FinalParagraphCellID"
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        registerCell()
    }
}

extension ICDFIntroductionViewController{
    fileprivate func registerCell(){
        collectionView.register(ParagraphCell.self, forCellWithReuseIdentifier: paragraphCellID)
        collectionView.register(FinalParagraphCell.self, forCellWithReuseIdentifier: finalParagraphCellID)

        
    }
    
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        collectionView.fullAnchor(superView: view)
    }
}


extension ICDFIntroductionViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: finalParagraphCellID, for: indexPath) as! FinalParagraphCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: paragraphCellID, for: indexPath) as! ParagraphCell
            cell.setupUI(indexPath: indexPath)
            cell.setValue(introductionParagraph: paragraphsIntroduction[indexPath.item])
            return cell
        }
    }
}


extension ICDFIntroductionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 4:
            return CGSize(width: collectionView.bounds.width, height: ICDFINtroductionConstant.FinalParagraphCellHeight.rawValue)
        default:
            return CGSize(width: collectionView.bounds.width, height: ICDFINtroductionConstant.ParagraphCommomCellHeight.rawValue)
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
