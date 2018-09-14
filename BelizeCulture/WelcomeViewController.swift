//
//  WelcomeViewController.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/7.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import Lottie
import AVKit
import AVFoundation

class WelcomeViewController: UIViewController {
    var timer = Timer()
    
    var player: AVPlayer?
    var musicPlayer :AVAudioPlayer?
    lazy var welcomeAnimationView: LOTAnimationView = {
        let animationView = LOTAnimationView()
        animationView.setAnimation(named: "welcome")
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        animationView.animationSpeed = 1.0
        return animationView
    }()
    
    lazy var gifImgView: UIImageView = {
       let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()
    
    lazy var skipButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("skip >>", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(goToMainVC), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        return btn
    }()
    
    @objc func goToMainVC(){
        let mainVC = MainViewController()
        mainVC.setupTrailView(belowSubview: mainVC.johnButton)
        let naviVC = UINavigationController(rootViewController: mainVC)
        naviVC.isNavigationBarHidden = true
        present(naviVC, animated: true){
            self.timer.invalidate()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupWelcomeAnimationView()
//        setupGifView()
//        let videoLauncher = VideoLauncher()
//        videoLauncher.showVideoPlayer()
        setupPlayView()
        setupGoToSkipButton()
        setupBackgroundMusic()
       
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

}

extension WelcomeViewController{
    fileprivate func setupWelcomeAnimationView() {
        view.addSubview(welcomeAnimationView)
        welcomeAnimationView.fullAnchor(superView: view, topPadding: 50, bottomPadding: 100, leftPadding: 30, rightPadding: 30)
        welcomeAnimationView.play()
    }
    
    
    fileprivate func setupGifView() {
        view.addSubview(gifImgView)
        gifImgView.fullAnchor(superView: view, topPadding: 50, bottomPadding: 100, leftPadding: 30, rightPadding: 30)
        gifImgView.loadGif(name: "suck")
    }
    
    fileprivate func setupGoToSkipButton(){
        view.addSubview(skipButton)
        skipButton.anchor(top: nil, bottom: view.bottomAnchor, left: nil, right: view.rightAnchor, topPadding: 0, bottomPadding: 20, leftPadding: 0, rightPadding: 20, width: 150, height: 50)
        skipButton.alpha = 0.0
        UIView.animate(withDuration: 1.0, delay: 4.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.skipButton.alpha = 1.0
        }, completion: nil)
    }
    
    fileprivate func setupPlayView(){
        //定义一个视频文件路径
        let filePath = Bundle.main.path(forResource: "intro", ofType: "mp4")
        let videoURL = URL(fileURLWithPath: filePath!)
        //定义一个视频播放器，通过本地文件路径初始化
        player = AVPlayer(url: videoURL)
        //设置大小和位置（全屏）
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 800)
        //添加到界面上
        view.layer.addSublayer(playerLayer)
        //开始播放
        player?.play()
        NotificationCenter.default.addObserver(self,
                         selector: #selector(moviePlayBackFinished),
                         name: .AVPlayerItemDidPlayToEndTime,
                         object: nil)
    }
    
    @objc func moviePlayBackFinished(){
//        sleep(5)
//        DispatchQueue.main.async {[weak self] in
//            self?.goToMainVC()
//        }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(goToMainVC), userInfo: nil, repeats: false)
    }
    
    fileprivate func setupBackgroundMusic(){
        
        guard let soundPath = Bundle.main.path(
            forResource: "backgroundMusic", ofType: "mp3") else {return}
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath) )
            // 重複播放次數 設為 0 則是只播放一次 不重複
            musicPlayer?.numberOfLoops = Int(MAX_INPUT)
        } catch {
            print("error")
        }
        
        musicPlayer?.play()
    }
}
