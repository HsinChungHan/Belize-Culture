//
//  WebViewTableViewCell.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/9.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class WebViewTableViewCell: BasicTableViewCell {
    var website: String?{
        didSet{
            guard let website = website else {return}
            let url = URL(string: website)!
            webView.loadRequest(URLRequest(url: url))
        }
    }
    lazy var webView: UIWebView = {
        let wv = UIWebView()
        wv.delegate = self
        return wv
    }()
    
    override func setupViews() {
        setupWebView()
    }

}


extension WebViewTableViewCell{
    fileprivate func setupWebView(){
        addSubview(webView)
        webView.fullAnchor(superView: self)
    }
    public func setValue(website: String){
        self.website = website
    }
}

extension WebViewTableViewCell: UIWebViewDelegate{
    
}
