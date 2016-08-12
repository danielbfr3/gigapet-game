//
//  ViewController.swift
//  gigapet
//
//  Created by Daniel Boga on 09/05/16.
//  Copyright © 2016 Daniel Boga. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImage: MonsterImage!
    @IBOutlet weak var heartImage: DragImage!
    @IBOutlet weak var foodImage: DragImage!
    @IBOutlet weak var penaltyOneImage: UIImageView!
    @IBOutlet weak var penaltyTwoImage: UIImageView!
    @IBOutlet weak var penaltyThreeImage: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    var currentPenalties = 0
    var timer: NSTimer!
    var isMonsterHappy: Bool = false
    
    var sfxBite: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heartImage.dropTarget = monsterImage
        foodImage.dropTarget = monsterImage
        
        penaltyOneImage.alpha = DIM_ALPHA
        penaltyTwoImage.alpha = DIM_ALPHA
        penaltyThreeImage.alpha = DIM_ALPHA
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        musicPlayer.prepareToPlay()
        sfxBite.prepareToPlay()
        sfxDeath.prepareToPlay()
        sfxHeart.prepareToPlay()
        sfxSkull.prepareToPlay()
        
        musicPlayer.play()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDrop", object: nil)
        
        startTimer()
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        isMonsterHappy = true
        startTimer()
        changeGameState()
        randomAffection()
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        if isMonsterHappy {
            currentPenalties -= 1
        } else if !isMonsterHappy {
            currentPenalties += 1
            sfxSkull.play()
        }
        
        switch currentPenalties {
        case 1:
            penaltyOneImage.alpha = OPAQUE
            penaltyTwoImage.alpha = DIM_ALPHA
            penaltyThreeImage.alpha = DIM_ALPHA
        case 2:
            penaltyOneImage.alpha = OPAQUE
            penaltyTwoImage.alpha = OPAQUE
            penaltyThreeImage.alpha = DIM_ALPHA
        case 3:
            penaltyOneImage.alpha = OPAQUE
            penaltyTwoImage.alpha = OPAQUE
            penaltyThreeImage.alpha = OPAQUE
        default:
            penaltyOneImage.alpha = DIM_ALPHA
            penaltyTwoImage.alpha = DIM_ALPHA
            penaltyThreeImage.alpha = DIM_ALPHA
        }
        
        if currentPenalties >= 3 {
            gameOver()
        } else if currentPenalties < 0 {
            currentPenalties = 0
        }
        
        isMonsterHappy = false
        
    }
    
    func gameOver() {
        timer.invalidate()
        musicPlayer.stop()
        sfxDeath.play()
        monsterImage.playDeathAnimation()
    }
    
    func randomAffection() {
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            heartImage.alpha = DIM_ALPHA
            heartImage.userInteractionEnabled = false
            
            foodImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = true
            sfxHeart.play()
        } else {
            heartImage.alpha = OPAQUE
            heartImage.userInteractionEnabled = true
            
            foodImage.alpha = DIM_ALPHA
            foodImage.userInteractionEnabled = false
            sfxBite.play()
        }
    }

}

