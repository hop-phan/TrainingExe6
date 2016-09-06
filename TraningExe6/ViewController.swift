//
//  ViewController.swift
//  TraningExe6
//
//  Created by HopPD on 9/1/16.
//  Copyright © 2016 HopPD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isClickedCard1 : Bool = false
    var isClickedCard2 : Bool = false
    var isClickedCard3 : Bool = false
    var isClickedCard4 : Bool = false
    var isSameImage : Bool = false
    var isPaired : Bool = false
    var isDeletedAll : Bool = false
    var numberOfOpenedImange : Int = 0
    var showingCard : Array<UIImageView> = []
    var deletedPairNumber : Int = 0
    var allPairs = [[String]]()
    var pair1 = [String]()
    var pair2 = [String]()
    var timer: NSTimer?
    var p : Double = 10.0
    
    //MARK:Properties
    
    @IBOutlet weak var card1: UIImageView!
    
    @IBOutlet weak var card2: UIImageView!
    
    @IBOutlet weak var card3: UIImageView!
    
    @IBOutlet weak var card4: UIImageView!
    
    @IBOutlet weak var progressGame: UIProgressView!
    var alertGameOver = UIAlertController(title: "GAME OVER", message: "GAME OVER", preferredStyle: UIAlertControllerStyle.Alert)
    let alertWin = UIAlertController(title: "WIN", message: "WIN", preferredStyle: UIAlertControllerStyle.Alert)
    
    func loadInitialize (){
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target : self , selector : Selector("updateTheProgress"), userInfo: nil, repeats: true)
        timer?.fire()
        let theDelayTime = 10.0
        let delayInNano = dispatch_time(DISPATCH_TIME_NOW, Int64(theDelayTime*Double(NSEC_PER_SEC)))
        let concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_after(delayInNano, concurrentQueue, {
            dispatch_async(dispatch_get_main_queue(), {
                self.timer?.invalidate()
                if (!self.isDeletedAll){
                    self.alertGameOver.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                        action in switch action.style {
                        case .Default:
                            self.navigationController?.popViewControllerAnimated(true)
                        default: break
                        }
                    }))
                    self.presentViewController(self.alertGameOver, animated: true, completion: nil)
                    
                }
            })
            
        })
    }
    
    func deleteImage(){
        
        showingCard[0].image = nil
        showingCard[1].image = nil
        showingCard[0].userInteractionEnabled = false
        showingCard[1].userInteractionEnabled = false
        showingCard.removeAll()
        deletedPairNumber += 1
        if (deletedPairNumber == 2 ) {
            isDeletedAll = true
            self.timer?.invalidate()
            self.alertWin.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                action in switch action.style {
                case .Default:
                    self.navigationController?.popViewControllerAnimated(true)
                default: break
                }
            }))
            self.presentViewController(self.alertWin, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.progressGame.trackTintColor = UIColor.brownColor()
        self.progressGame.progressTintColor = UIColor.blueColor()
    }
    
    func updateTheProgress (){
        self.progressGame.progress = (Float)(p/100.0)
        p += 10.0
    }
    
    
    
    func allPairInitialization() {
        pair1.append("card1")
        pair1.append("card3")
        
        pair2.append("card2")
        pair2.append("card4")
        
        allPairs.append(pair1)
        allPairs.append(pair2)
        
    }
    
    
    func checkTrueFalse () {
        if numberOfOpenedImange == 2 {
            numberOfOpenedImange = 0
            if checkSameimage(showingCard[0], card2: showingCard[1]) {
                deleteImage()
            }
            else {
                clearAndBackCard()
            }
        }
    }
    
    
    
    func clearAndBackCard(){
        
        let theDelayTime = 0.4
        let delayInNano = dispatch_time(DISPATCH_TIME_NOW, Int64(theDelayTime*Double(NSEC_PER_SEC)))
        let concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_after(delayInNano, concurrentQueue, {
            dispatch_async(dispatch_get_main_queue(), {
                self.showingCard[0].image = UIImage(named: "backCard.jpg")
                self.showingCard[1].image = UIImage(named: "backCard.jpg")
                self.isClickedCard1  = false
                self.isClickedCard2  = false
                self.isClickedCard3  = false
                self.isClickedCard4  = false
                self.showingCard.removeAll()
            })
        })
        
    }
    
    
    
    func checkSameimage( card1 : UIImageView, card2 : UIImageView ) -> (Bool) {
        for var i = 0; i < allPairs.count ; ++i {
            isSameImage = isSameImage || (allPairs[i][0] == card1.restorationIdentifier && allPairs[i][1] == card2.restorationIdentifier) || (allPairs[i][0] == card2.restorationIdentifier && allPairs[i][1] == card1.restorationIdentifier)
        }
        return isSameImage
    }
    
    
    
    @IBAction func tapcard1(sender: AnyObject) {
        
        isClickedCard1 = !isClickedCard1
        if isClickedCard1{
            showingCard.append(card1)
            numberOfOpenedImange += 1
            print ("tapcard1: \(numberOfOpenedImange)" )
            card1.image = UIImage(named: "duck.jpg")
        }else {
            showingCard.removeLast()
            numberOfOpenedImange -= 1
            print ("tapcard1: \(numberOfOpenedImange)" )
            card1.image = UIImage(named: "backCard.jpg")
        }
        checkTrueFalse()
    }
    
    
    
    @IBAction func card1SwipeRight(sender: AnyObject) {
        isClickedCard1 = !isClickedCard1
        if isClickedCard1 {
            showingCard.append(card1)
            numberOfOpenedImange += 1
            print ("swipeRCard1: \(numberOfOpenedImange)" )
            card1.image = UIImage(named: "duck.jpg")
        }else {
            showingCard.removeLast()
            numberOfOpenedImange -= 1
            card1.image = UIImage(named: "backCard.jpg")
        }
        if numberOfOpenedImange == 2 {
            numberOfOpenedImange = 0
            if checkSameimage(showingCard[0], card2: showingCard[1]) {
                showingCard[0].image = nil
                showingCard[1].image = nil
                showingCard[0].userInteractionEnabled = false
                showingCard[1].userInteractionEnabled = false    }
            else {
                showingCard[0].image = UIImage(named: "backCard.jpg")
                showingCard[1].image = UIImage(named: "backCard.jpg")
            }
        }
        
    }
    
    
    @IBAction func card1SwipeLeft(sender: AnyObject) {
        isClickedCard1 = !isClickedCard1
        if isClickedCard1 {
            showingCard.append(card1)
            numberOfOpenedImange += 1
            print ("swipeLCard1: \(numberOfOpenedImange)" )
            card1.image = UIImage(named: "rabbit.jpg")
        }else {
            showingCard.removeLast()
            numberOfOpenedImange -= 1
            card1.image = UIImage(named: "backCard.jpg")
        }
        if numberOfOpenedImange == 2 {
            numberOfOpenedImange = 0
            if checkSameimage(showingCard[0], card2: showingCard[1]) {
                showingCard[0].image = nil
                showingCard[1].image = nil
                showingCard[0].userInteractionEnabled = false
                showingCard[1].userInteractionEnabled = false
            }
            else {
                showingCard[0].image = UIImage(named: "backCard.jpg")
                showingCard[1].image = UIImage(named: "backCard.jpg")
            }
        }
    }
    
    @IBAction func tapcard2(sender: AnyObject) {
        isClickedCard2 = !isClickedCard2
        if isClickedCard2{
            
            
            showingCard.append(card2)
            numberOfOpenedImange += 1
            print ("tapcard2: \(numberOfOpenedImange)" )
            card2.image = UIImage(named: "rabbit.jpg")
        }else {
            numberOfOpenedImange -= 1
            print ("tapcard2: \(numberOfOpenedImange)" )
            
            showingCard.removeLast()
            
            
            card2.image = UIImage(named: "backCard.jpg")
        }
        checkTrueFalse()
        
    }
    
    
    @IBAction func card2SwipeRight(sender: AnyObject) {
        
        isClickedCard2 = !isClickedCard2
        if isClickedCard2 {
            showingCard.append(card2)
            
            numberOfOpenedImange += 1
            card2.image = UIImage(named: "rabbit.jpg")
        }else {
            showingCard.removeLast()
            
            numberOfOpenedImange -= 1
            card2.image = UIImage(named: "backCard.jpg")
        }
        checkTrueFalse()
    }
    
    
    @IBAction func card2SwipeLeft(sender: AnyObject) {
        isClickedCard2 = !isClickedCard2
        if isClickedCard2 {
            showingCard.append(card2)
            numberOfOpenedImange += 1
            card2.image = UIImage(named: "duck.jpg")
        }else {
            showingCard.removeLast()
            numberOfOpenedImange -= 1
            card2.image = UIImage(named: "backCard.jpg")
        }
        checkTrueFalse()
        
    }
    
    @IBAction func tapcard4(sender: AnyObject) {
        isClickedCard4 = !isClickedCard4
        if isClickedCard4{
            numberOfOpenedImange += 1
            print ("tapcard4: \(numberOfOpenedImange)" )
            
            showingCard.append(card4)
            
            card4.image = UIImage(named: "rabbit.jpg")
        }else {
            
            numberOfOpenedImange -= 1
            print ("tapcard4: \(numberOfOpenedImange)" )
            showingCard.removeLast()
            card4.image = UIImage(named: "backCard.jpg")
        }
        checkTrueFalse()
    }
    
    
    @IBAction func card4SwipeRight(sender: AnyObject) {
        
        isClickedCard4 = !isClickedCard4
        if isClickedCard4 {
            showingCard.append(card4)
            numberOfOpenedImange += 1
            card4.image = UIImage(named: "rabbit.jpg")
        }else {
            showingCard.removeLast()
            numberOfOpenedImange -= 1
            card4.image = UIImage(named: "backCard.jpg")
        }
        checkTrueFalse()    }
    
    
    @IBAction func card4SwipeLeft(sender: AnyObject) {
        isClickedCard4 = !isClickedCard4
        if isClickedCard4 {
            showingCard.append(card4)
            numberOfOpenedImange += 1
            card4.image = UIImage(named: "duck.jpg")
        }else {
            showingCard.removeLast()
            numberOfOpenedImange -= 1
            card4.image = UIImage(named: "backCard.jpg")
        }
        checkTrueFalse()
    }
    
    
    @IBAction func tapcard3(sender: AnyObject) {
        
        
        
        isClickedCard3 = !isClickedCard3
        if isClickedCard3{
            numberOfOpenedImange += 1
            print ("tapcard3: \(numberOfOpenedImange)" )
            
            showingCard.append(card3)
            
            card3.image = UIImage(named: "duck.jpg")
        }else {
            numberOfOpenedImange -= 1
            print ("tapcard3 : \(numberOfOpenedImange)" )
            
            showingCard.removeLast()
            
            card3.image = UIImage(named: "backCard.jpg")
        }
        checkTrueFalse()
    }
    
    
    @IBAction func card3SwipeRight(sender: AnyObject) {
        isClickedCard3 = !isClickedCard3
        if isClickedCard3 {
            showingCard.append(card3)
            numberOfOpenedImange += 1
            card3.image = UIImage(named: "duck.jpg")
        }else {
            showingCard.removeLast()
            numberOfOpenedImange -= 1
            card3.image = UIImage(named: "backCard.jpg")
        }
        checkTrueFalse()
    }
    
    
    @IBAction func card3SwipeLeft(sender: AnyObject) {
        
        isClickedCard3 = !isClickedCard3
        if isClickedCard3 {
            showingCard.append(card3)
            numberOfOpenedImange += 1
            card3.image = UIImage(named: "duck.jpg")
        }else {
            showingCard.removeLast()
            numberOfOpenedImange -= 1
            card3.image = UIImage(named: "backCard.jpg")
        }
        checkTrueFalse()    }
    
    
    override func viewDidLoad(  ) {
        super.viewDidLoad()
        allPairInitialization()
        loadInitialize()
        // addGestures()
        
    }
}




