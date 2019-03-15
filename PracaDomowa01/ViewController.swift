//
//  ViewController.swift
//  PracaDomowa01
//
//  Created by Aleksandra Konopka on 12/03/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
//        view.addGestureRecognizer(longGesture)
        view.addGestureRecognizer(doubleTap)
    }
//5. Podniesienie i przenoszenie obsłuż przy pomocy `UILongPressGestureRecognizer`
    @objc func longGestureFunc(_ tap: UILongPressGestureRecognizer) {
       let point = tap.location(in: self.view)
        if let chosenBall = self.view.hitTest(point, with: nil)
        {
            if chosenBall != self.view{
                if tap.state == .began
                {
                    animation(myBall: chosenBall, scale: 1.2, alpha: 0.6 ,duration: 0.3)
                    print("Centrum: \(chosenBall.center)")
                    print("W view: \(tap.location(in: self.view))")
                    print("W chosenBall\(tap.location(in: chosenBall))")
                    //print("Frame: \(chosenBall.frame.height)")
                    print("Bounds: \(chosenBall.bounds.height)")
                }
                
                if tap.state == .changed
                {
                    print(chosenBall.center)
                    chosenBall.center.x =  tap.location(in: self.view).x - tap.location(in: chosenBall).x + (1/2)*chosenBall.bounds.height
                    chosenBall.center.y =  tap.location(in: self.view).y - tap.location(in: chosenBall).y + (1/2)*chosenBall.bounds.width
                    print(chosenBall.center)
                }
                if tap.state == .ended
                {
                    animation(myBall: chosenBall, scale: 1 , alpha: 1.0, duration: 0.3)
                }
            //click.removeFromSuperview()
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
