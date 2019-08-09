//
//  MapViewController.swift
//  MusicPlayer
//
//  Created by 苏强 on 2019/8/9.
//  Copyright © 2019 black. All rights reserved.
//

import UIKit

class MapViewController: BaseViewController {

    let scrollView: UIScrollView  = UIScrollView.init()
    let mapImageView: UIImageView = UIImageView.init(image: UIImage(named: "11"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入地图页面")
        setNav()
        setUI()
        addNot()
    }
    
    private func setNav() {
        self.title = "ImageView缩放"
    }
    
    private func setUI() {
        scrollView.frame = self.view.bounds
        scrollView.contentSize = self.view.bounds.size
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.75
        scrollView.maximumZoomScale = view.bounds.height / view.bounds.width
        scrollView.backgroundColor = UIColor.black
        view.addSubview(scrollView)
        
        mapImageView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        mapImageView.center = scrollView.center
        view.addSubview(mapImageView)
        
    }
    
    private func addNot() {
        NotificationCenter.default.addObserver(self, selector:#selector(willResionActive),name: UIApplication.willResignActiveNotification,object: nil)
    }
    
    @objc func willResionActive() {
        navigationController?.popViewController(animated: true)
    }
}

extension MapViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapImageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let targetView = viewForZooming(in: scrollView)
        guard targetView != nil else {
            return
        }
        let widthIsSmall = (targetView?.bounds.width)! < scrollView.bounds.width
        let heightIsSmall = (targetView?.bounds.height)! < scrollView.bounds.height
        if (widthIsSmall) {
            
        } else {
            targetView?.center.x = scrollView.center.x
        }
        if (heightIsSmall) {
            
        } else {
            targetView?.center.y = scrollView.center.y
        }
        
    }
    
}
