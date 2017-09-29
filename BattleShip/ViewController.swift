//
//  ViewController.swift
//  BattleShip
//
//  Created by Thej on 9/27/17.
//  Copyright © 2017 Thej. All rights reserved.
//

import UIKit
import FirebaseDatabase
import AVFoundation

class ViewController: UIViewController {
    
    var imageCount = 1
    var ref:DatabaseReference?
    var faces = [Int]()
    var face1 = [Int]()
    var face2 = [Int]()
    var playernum = [String]()
    var playernumber = Int()
    var handle:DatabaseHandle?
    
    var tag = [Int]()
    var winnertag = String()
    
    var audioPlayer = AVAudioPlayer()
    
    
    @IBOutlet weak var ScoreOutlet: UILabel!
    @IBOutlet weak var UserinfoOutlet: UILabel!
    
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
    
    lazy var buttons: [UIButton] = [self.Button1Outlet, self.Button2Outlet, self.Button3Outlet, self.Button4Outlet, self.Button5Outlet, self.Button6Outlet, self.Button7Outlet, self.Button8Outlet, self.Button9Outlet, self.Button10Outlet, self.Button11Outlet, self.Button12Outlet, self.Button13Outlet, self.Button14Outlet, self.Button15Outlet]
    
    @IBOutlet weak var ReadyButtonOutlet: UIButton!
    @IBAction func ReadyButton(_ sender: UIButton) {
        
        if (ReadyButtonOutlet.titleLabel?.text == "Ready") {
        
            handle = ref?.child("player").observe(.childAdded, with: { (snapshot) in
                if let item2 = snapshot.value as? String {
                    print("item----->", item2)
                    self.playernum.append(item2)
                }
            })
        
            if (playernum.count == 0) {
                self.ref?.child("player").childByAutoId().setValue("ImIn")
            }
        
            sender.setTitle("Start", for: .normal)
        
        } else {
            print(playernum)
            player()
            if (playernumber == 1) {
                ref?.child("list1").childByAutoId().setValue(faces)
                for button in self.buttons {
                    button.isEnabled = true
                }
            } else {
                ref?.child("list1").childByAutoId().setValue(faces)
                for button in self.buttons {
                    button.isEnabled = false
                }
            }
            print("playernumber from startbutton", playernumber)
            sender.isHidden = true
            UserinfoOutlet.text = "Lets Go!"
            
        }
        
    
    }
    
    func player() {
        playernumber = playernum.count
    }
    
    
    func myDeleteFunction(childIWantToRemove: String) {
        
        ref?.child(childIWantToRemove).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            }
        }
    }
    
    @IBOutlet weak var PlayAgainPressedOutlet: UIButton!
    @IBAction func PlayAgainPressed(_ sender: UIButton) {
        imageCount = 1
        for button in self.buttons {
            button.isEnabled = true
            button.setImage(nil, for: .normal)
        }
        score = 5
        UserinfoOutlet.text = "Choose you Defenders"
        ScoreOutlet.text = String(score)
        ReadyButtonOutlet.setTitle("Ready", for: .normal)
        faces = [Int]()
        viewDidLoad()
    }

    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        print(sender.tag)
        
        if imageCount == 1 {
            sender.setImage(UIImage(named: "1.png"), for: UIControlState.normal)
            faces.append(sender.tag)
            sender.isEnabled = false
            imageCount += 1
        }
        else if imageCount == 2 {
            sender.setImage(UIImage(named: "gtimage2"), for: UIControlState.normal)
            faces.append(sender.tag)
            sender.isEnabled = false
            imageCount += 1
        }
        else if imageCount == 3 {
            sender.setImage(UIImage(named: "gtimage3"), for: UIControlState.normal)
            faces.append(sender.tag)
            sender.isEnabled = false
            imageCount += 1
        }
        else if imageCount == 4 {
            sender.setImage(UIImage(named: "gtimage4"), for: UIControlState.normal)
            faces.append(sender.tag)
            sender.isEnabled = false
            imageCount += 1
        }
        else if imageCount == 5 {
            sender.setImage(UIImage(named: "gtimage5"), for: UIControlState.normal)
            faces.append(sender.tag)
            imageCount += 1
            ReadyButtonOutlet.isHidden = false
            for button in self.buttons {
                button.isEnabled = false
            }
            
        } else {
            if (score > 0) {
                print("faces--->", faces)
                self.ref?.child("tag").childByAutoId().setValue([playernumber, sender.tag])
                print("tag:", tag)
                for button in self.buttons {
                    button.isEnabled = false
                }
                UserinfoOutlet.text = "Opponent's Turn!"
            }
            else {
                print("winner")
                UserinfoOutlet.text = "Game Over - You Lost"
                
                for button in self.buttons {
                    button.isEnabled = false
                }
                PlayAgainPressedOutlet.isHidden = false
                winnertag = "Ilostalready"
                self.ref?.child("Ilost").childByAutoId().setValue("Ilost")
            }
        }
    }

    
    var cellcount = 0
    var score = 5
    func celldestroyed() {
        // divideface()
        // tag = [1,15]
        if cellcount > 0 {
            print("playernumber-->", playernumber)
            print("scoreval:", score)
            if (playernumber == 1) {
                print("hellow1")
                print("dfgdgd",faces)
                for i in 0...4 {
                    print(faces[i])
                    if (faces[i] == tag[1]) {
                        print("lower score")
                        score -= 1
                        ScoreOutlet.text = String(score)
                    }
                }
            } else {
                print("hellow1")
                for i in 5...((faces.count)-1) {
                    if faces[i] == tag[1] {
                        score -= 1
                        ScoreOutlet.text = String(score)
                    }
                }
            }
        }
        cellcount = 1
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSound(file: "GameofThrones")

//        UIButton.appearance().borderColor = UIColor.gray;
        UIButton.appearance().borderWidth = 2;
       // UIButton.appearance().backgroundColor = UIColor.yellow
        //        UIButton.appearance().cornerRadius = 20;
        
        myDeleteFunction(childIWantToRemove: "tag")
        myDeleteFunction(childIWantToRemove: "list1")
        myDeleteFunction(childIWantToRemove: "player")
        myDeleteFunction(childIWantToRemove: "Ilost")
        
        ReadyButtonOutlet.isHidden = true
        PlayAgainPressedOutlet.isHidden = true
        
        ref = Database.database().reference()

//        if (playernumber == 1) {
//            print("playernumber from above-->", playernumber)
//            handle = ref?.child("list2").observe(.childAdded, with: { (snapshot) in
//                if let item = snapshot.value as? [Int] {
//                    self.faces = item
//                }
//            })
//        } else {
//            print("playernumber -->", playernumber)
            handle = ref?.child("list1").observe(.childAdded, with: { (snapshot) in
                if let item2 = snapshot.value as? [Int] {
                    self.faces = item2
                }
            })
//        }
        
        handle = ref?.child("tag").observe(.childAdded, with: { (snapshot) in
            if let item3 = snapshot.value as? [Int] {
                self.tag = item3
//                if (self.score == 0) {
//                    print("winner")
//                    self.UserinfoOutlet.text = "You Won"
//                    
//                }
                 if (self.playernumber == 1) {
                    if (self.tag[0] == 2) {
                        self.celldestroyed()
                        for button in self.buttons {
                            button.isEnabled = true
                        }
                        self.UserinfoOutlet.text = "Your Turn!"
                    }
                } else {
                    if (self.tag[0] == 1) {
                        self.celldestroyed()
                        for button in self.buttons {
                            button.isEnabled = true
                        }
                        self.UserinfoOutlet.text = "Your Turn!"

                    }
                }
            }
        })
        
        handle = ref?.child("Ilost").observe(.childAdded, with: { (snapshot) in
            if let item4 = snapshot.value as? String {
                if self.winnertag != "Ilostalready" {
                    self.UserinfoOutlet.text = "Game Over - You Won"
                    self.PlayAgainPressedOutlet.isHidden = false
                }
            }
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func playSound(file: String){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: file, ofType: "mp3")!))
            print("hello")
            //audioPlayer = audioPlayers[send,
            //audioPlayers[file].play()
            audioPlayer.play()
            let audioSession = AVAudioSession.sharedInstance()
            
            do{
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            }
            catch{
                //
            }
        }
        catch {
            print(error)
        }
        
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


// FOR MULTIPEERCONNECTIVITY --->

/* //
 //  ViewController.swift
 //  BattleShip
 //
 //  Created by Thej on 9/27/17.
 //  Copyright © 2017 Thej. All rights reserved.
 //
 
 import UIKit
 import MultipeerConnectivity
 
 class ViewController: UIViewController, MCBrowserViewControllerDelegate {
 
 var appDelegate: AppDelegate!
 
 var imageCount = 1
 
 @IBOutlet weak var UserinfoOutlet: UILabel!
 
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
 if appDelegate.mpcHandler.session != nil{
 appDelegate.mpcHandler.setupBrowser()
 appDelegate.mpcHandler.browser.delegate = self
 
 print("hello5")
 
 
 self.present(appDelegate.mpcHandler.browser, animated: true, completion: nil)
 print("hello6")
 }
 
 
 
 
 }
 
 func peerChangedStateWithNotification(notificaiton: NSNotification){
 print("hello7")
 let userInfo = NSDictionary(dictionary: notificaiton.userInfo!)
 let state = userInfo.object(forKey: "state") as! Int
 
 if state != MCSessionState.connecting.rawValue{
 print("hello2")
 self.UserinfoOutlet.text = "Connected"
 } else {
 print("hello1")
 }
 
 }
 
 
 func handleReceivedDataWithNotification(notificaiton: NSNotification) {
 
 }
 
 
 
 func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
 appDelegate.mpcHandler.browser.dismiss(animated: true, completion: nil)
 }
 
 func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
 appDelegate.mpcHandler.browser.dismiss(animated: true, completion: nil)
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
 
 // ReadyButtonOutlet.isHidden = true
 PlayAgainPressedOutlet.isHidden = true
 // Do any additional setup after loading the view, typically from a nib.
 appDelegate = UIApplication.shared.delegate as! AppDelegate
 
 appDelegate.mpcHandler.setupPeerWithDisplayName(displayName: UIDevice.current.name)
 appDelegate.mpcHandler.setupSession()
 appDelegate.mpcHandler.advertiseSelf(advertise: true)
 //        NotificationCenter.default.addObserver(self, selector: Selector(("peerChangedStateWithNotification:")), name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil)
 //
 //          NotificationCenter.default.addObserver(self, selector: Selector(("handleReceivedDataWithNotification:")), name: NSNotification.Name(rawValue: "MPC_DidReceiveDataNotification"), object: nil)
 
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
 
*/
