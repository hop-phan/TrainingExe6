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
    
    @IBOutlet weak var card1: UIImageView!
    
    @IBAction func tapcard1(sender: AnyObject) {
        isClickedCard1 = !isClickedCard1
        if isClickedCard1{
            card1.image = UIImage(named: "duck.jpg")
        }else {
            card1.image = UIImage(named: "backCard.jpg")
        }
    }
    
    
    @IBAction func card1SwipeRight(sender: AnyObject) {
        
        isClickedCard1 = !isClickedCard1
        if isClickedCard1 {
            card1.image = UIImage(named: "duck.jpg")
        }else {
            card1.image = UIImage(named: "backCard.jpg")
        }
    }
    
    
    @IBAction func card1SwipeLeft(sender: AnyObject) {
        isClickedCard1 = !isClickedCard1
        if isClickedCard1 {
            card1.image = UIImage(named: "duck.jpg")
        }else {
            card1.image = UIImage(named: "backCard.jpg")
        }
        
    }
    
    override func viewDidLoad(  ) {
        super.viewDidLoad()       
        
    }
}




