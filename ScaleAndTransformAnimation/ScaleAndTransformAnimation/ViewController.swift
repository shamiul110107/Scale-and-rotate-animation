//
//  ViewController.swift
//  ScaleAndTransformAnimation
//
//  Created by sami on 14/9/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    var isStart = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.rotate(duration: 2)
        imgView.scaleUpAndDown()

    }
}

extension UIView {
    func rotate(duration: TimeInterval) {
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: [.curveLinear,.autoreverse], animations: {
                        let angle = Double.pi
                        self.transform = self.transform.rotated(by: CGFloat(angle))
        }, completion: {[weak self] finished in
            guard let strongSelf = self else {
                return
            }
            if finished &&
                self?.transform != CGAffineTransform.identity {
                strongSelf.rotate(duration: duration)
            } else {
                // rotation ending
            }
        })
    }
    
    
    func scaleUpAndDown(timesRepeated: Int = 0) {
        
        let repeatedCount = timesRepeated + 1
        
        UIView.animate(withDuration: 2,
                       delay: 0.0,
                       animations: {
                        let desiredOriginalScale: CGFloat = 1
                        
                        let scaleX = abs(CGAffineTransform.identity.a / self.transform.a) * desiredOriginalScale
                        let scaleY = abs(CGAffineTransform.identity.d / self.transform.d) * desiredOriginalScale
                        
                        self.transform = self.transform.scaledBy(x: scaleX, y: scaleY)
        }) { (true) in
            UIView.animate(withDuration:2,
                           delay: 0.0,
                           animations: {
                            
                            let desiredOriginalScale: CGFloat = 0.7
                            
                            let scaleX = abs(CGAffineTransform.identity.a / self.transform.a) * desiredOriginalScale
                            let scaleY = abs(CGAffineTransform.identity.d / self.transform.d) * desiredOriginalScale
                            self.transform = self.transform.scaledBy(x: scaleX, y: scaleY)
            }) { finshed in
                    self.scaleUpAndDown(timesRepeated: repeatedCount)
            }
        }
    }
}
