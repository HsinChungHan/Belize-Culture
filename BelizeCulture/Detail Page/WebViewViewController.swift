//
//  WebViewViewController.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/9.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    var website: String?{
        didSet{
            guard let website = website else {return}
            let url = URL(string: website)!
            webView.load(URLRequest(url: url))
        }
    }
    lazy var webView: WKWebView = {
       let wv = WKWebView()
        return wv
    }()
    
    lazy var backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(btnFunc), for: .touchUpInside)
        btn.setImage(UIImage(named: "Back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    @objc func btnFunc(){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setBackButton()

    }
    
}

extension WebViewViewController{
    fileprivate func setBackButton(){
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 60, height: 60)
    }
    
   
    
    fileprivate func setupWebView(){
        view.addSubview(webView)
        webView.fullAnchor(superView: view)
        webView.navigationDelegate = self

    }
    public func setValue(website: String){
        self.website = website
    }
    
    
}

extension WebViewViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // 顯示進度條
        print("start")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 隱藏進度條
       print("end")
    }
}
