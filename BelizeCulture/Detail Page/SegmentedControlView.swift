//
//  SegmenteContolView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/13.
//  Copyright © 2018 辛忠翰. All rights reserved.
//




import UIKit
protocol ChangeSegmentedContolValueProtocol {
    func changeCurrentValue(isInformation: Bool)
}



class SegmentedControlView: BasicView {
    var delegate: ChangeSegmentedContolValueProtocol?
    var isInformation = true
    
    
    fileprivate var values: [String]?{
        didSet{
            guard let values = values else {return}
            setupSegmentedControllValue(values: values)
        }
    }
//    fileprivate var currentValue: String?{
//        didSet{
//            guard let currentValue = currentValue else {return}
//            delegate?.changeCurrentValue(currentValue: currentValue)
//
//        }
//
//    }
    
    lazy var segmentedControl: UISegmentedControl = {
       let sc = UISegmentedControl()
        return sc
    }()
    
    @objc func segmentedContolValueChanged(){
//        currentValue = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControl.frame.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)
        }
        
        if segmentedControl.selectedSegmentIndex == 0{
            isInformation = true
        }else{
            isInformation = false
        }
        delegate?.changeCurrentValue(isInformation: isInformation)
    }
    
    let buttonBar: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.darkOrange
        view.layer.cornerRadius = 3.0
        view.clipsToBounds = true
        view.alpha = 0.6
        return view
    }()
    
    
    
    override func setupViews() {
        setupSegmentedControlView()
    }

}

extension SegmentedControlView{
    
    fileprivate func setupSegmentedControlView() {
        addSubview(segmentedControl)
        addSubview(buttonBar)
//        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        // Constrain the top of the button bar to the bottom of the segmented control
        buttonBar.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
    }
    
    fileprivate func setupSegmentedControllValue(values: [String]){
        for (value) in values{
            guard let index = values.firstIndex(of: value) else {return}
            segmentedControl.insertSegment(withTitle: value, at: index, animated: true)
            
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font :UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.classicBrown
            ], for: .normal)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.darkOrange.withAlphaComponent(0.6)
            ], for: .selected)
        
        
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.borderColor = UIColor.classicBrown.cgColor
        segmentedControl.layer.cornerRadius = 3.0
        segmentedControl.clipsToBounds = true

        segmentedControl.addTarget(self, action: #selector(segmentedContolValueChanged), for: .valueChanged)
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)).isActive = true
//        currentValue = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
    }
    
    public func setupValues(values: [String]){
        self.values = values
    }
}
