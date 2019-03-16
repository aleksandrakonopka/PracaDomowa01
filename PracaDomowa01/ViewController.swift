//
//  ViewController.swift
//  PracaDomowa01
//
//  Created by Aleksandra Konopka on 12/03/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController,UIGestureRecognizerDelegate {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.name = "double"
        let trippleTap = UITapGestureRecognizer(target: self, action: #selector(trippleTapped))
        trippleTap.name = "triple"
        trippleTap.numberOfTapsRequired = 3
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        trippleTap.delegate = self
        

        view.addGestureRecognizer(doubleTap)
        view.addGestureRecognizer(trippleTap)
    }
     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                    shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        if gestureRecognizer.name == "double"   &&
        otherGestureRecognizer.name == "triple" {
            return true
        }
        return false
    }
    
//5. Podniesienie i przenoszenie obsłuż przy pomocy `UILongPressGestureRecognizer`
    @objc func longGestureFunc(_ tap: UILongPressGestureRecognizer) {
                if let kulka = tap.view
                {
                    if tap.state == .began
                    {
                        animation(myBall: kulka, scale: 1.2, alpha: 0.6 ,duration: 0.3)
                    }
        
                    if tap.state == .changed
                    {
                        kulka.center.x =  tap.location(in: self.view).x - tap.location(in: kulka).x + (1/2)*kulka.bounds.height
                        kulka.center.y =  tap.location(in: self.view).y - tap.location(in: kulka).y + (1/2)*kulka.bounds.height
                    }
                    if tap.state == .ended
                    {
                        animation(myBall: kulka, scale: 1 , alpha: 1.0, duration: 0.3)
                    }
                }
            }

    @objc func doubleTapped(_ tap: UITapGestureRecognizer) {
        let size: CGFloat = 100
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureFunc))
        let spawnedView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        spawnedView.transform = CGAffineTransform(scaleX: 2, y: 2)
        spawnedView.center = tap.location(in: view)
        spawnedView.backgroundColor = UIColor.randomBrightColor()
        spawnedView.layer.cornerRadius = size * 0.5
        spawnedView.alpha = 0.0
        view.addSubview(spawnedView)
        animation(myBall: spawnedView, scale: 1, alpha: 1.0, duration: 0.3)
        spawnedView.addGestureRecognizer(longGesture)
        
    }
    @objc func trippleTapped(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: self.view)
            if let chosenBall = self.view.hitTest(point, with: nil)
            {
                if chosenBall != self.view{
                animation(myBall: chosenBall, scale: 2, alpha: 0.0, duration: 0.3)
                chosenBall.removeFromSuperview()
                }
            }
        
    }
    private func animation(myBall : UIView, scale: CGFloat, alpha: CGFloat, duration: TimeInterval)
    {
        UIView.animate(withDuration: duration, animations: {
            myBall.alpha = alpha
            myBall.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
}



extension CGFloat {
    static func random() -> CGFloat {
        return random(min: 0.0, max: 1.0)
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(max > min)
        return min + ((max - min) * CGFloat(arc4random()) / CGFloat(UInt32.max))
    }
}

extension UIColor {
    static func randomBrightColor() -> UIColor {
        return UIColor(hue: .random(),
                       saturation: .random(min: 0.5, max: 1.0),
                       brightness: .random(min: 0.7, max: 1.0),
                       alpha: 1.0)
    }
}
