//
//  ViewController.swift
//  BattleShip
//
//  Created by Thej on 9/27/17.
//  Copyright © 2017 Thej. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageCount = 1
    
    @IBOutlet weak var Button1Outlet: UIButton!
    @IBOutlet weak var Button2Outlet: UIButton!
    @IBOutlet weak var Button3Outlet: UIButton!
    @IBOutlet weak var Button4Outlet: UIButton!
    @IBOutlet weak var Button5Outlet: UIButton!
    @IBOutlet weak var Button6Outlet: UIButton!
    @IBOutlet weak var Button7Outlet: UIButton!
    @IBOutlet weak var Button8Outlet: UIButton!
    @IBOutlet weak var Button9Outlet: UIButton!
    @IBOutlet weak var Button10Outlet: UIButton!
    @IBOutlet weak var Button11Outlet: UIButton!
    @IBOutlet weak var Button12Outlet: UIButton!
    @IBOutlet weak var Button13Outlet: UIButton!
    @IBOutlet weak var Button14Outlet: UIButton!
    @IBOutlet weak var Button15Outlet: UIButton!
    
    @IBOutlet weak var ReadyButtonOutlet: UIButton!
    @IBAction func ReadyButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var PlayAgainPressedOutlet: UIButton!
    @IBAction func PlayAgainPressed(_ sender: UIButton) {
    }

    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        print(sender.tag)
        
        if imageCount == 1 {
            sender.setImage(UIImage(named: "1.png"), for: UIControlState.normal)
            imageCount += 1
        }
        else if imageCount == 2 {
            sender.setImage(UIImage(named: "gtimage2"), for: UIControlState.normal)
            imageCount += 1
        }
        else if imageCount == 3 {
            sender.setImage(UIImage(named: "gtimage3"), for: UIControlState.normal)
            imageCount += 1
        }
        else if imageCount == 4 {
            sender.setImage(UIImage(named: "gtimage4"), for: UIControlState.normal)
            imageCount += 1
        }
        else if imageCount == 5 {
            sender.setImage(UIImage(named: "gtimage5"), for: UIControlState.normal)
            imageCount += 1
            ReadyButtonOutlet.isHidden = false
        }
    }
    

    override func viewDidLoad() {	
        super.viewDidLoad()
//        UIButton.appearance().borderColor = UIColor.gray;
        UIButton.appearance().borderWidth = 2;
        UIButton.appearance().backgroundColor = UIColor.yellow
        //        UIButton.appearance().cornerRadius = 20;
        
        ReadyButtonOutlet.isHidden = true
        PlayAgainPressedOutlet.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// For Giving all Buttons Borders!
extension UIButton {
//    dynamic var borderColor: UIColor? {
//        get {
//            if let cgColor = layer.borderColor {
//                return UIColor(CGColor: cgColor)
//            }
//            return nil
//        }
//        set { layer.borderColor = newValue?.cgColor }
//    }
    dynamic var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    dynamic var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

