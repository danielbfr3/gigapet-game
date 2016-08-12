//
//  MonsterImage.swift
//  gigapet
//
//  Created by Daniel Boga on 10/05/16.
//  Copyright © 2016 Daniel Boga. All rights reserved.
//

import Foundation
import UIKit

class MonsterImage: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.playIdleAnimation()
    }
    
    func playIdleAnimation() {
        var imageArray = [UIImage]()
        
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil
        
        for x in 1...4 {
            if let image = UIImage(named: "idle\(x).png") {
                imageArray.append(image)
            } else {
                print("ERROR: Image 'idle\(x).png' doesn't exist in assets folder.")
            }
        }
        
        self.animationImages = imageArray
        self.animationDuration = NSTimeInterval(0.8)
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        var imageArray = [UIImage]()
        
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        
        for x in 1...5 {
            if let image = UIImage(named: "dead\(x).png") {
                imageArray.append(image)
            } else {
                print("ERROR: Image 'dead\(x).png' doesn't exist in assets folder.")
            }
        }
        
        self.animationImages = imageArray
        self.animationDuration = NSTimeInterval(0.8)
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
    func playRessurrectAnimation() {
        self.image = UIImage(named: "idle1.png")
        var imageArray = [UIImage]()
        self.animationImages = nil
        
        imageArray.append(UIImage(named: "dead5.png")!)
        imageArray.append(UIImage(named: "dead4.png")!)
        imageArray.append(UIImage(named: "dead3.png")!)
        imageArray.append(UIImage(named: "dead2.png")!)
        imageArray.append(UIImage(named: "dead1.png")!)
            
        self.animationImages = imageArray
        self.animationDuration = NSTimeInterval(1)
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
}








