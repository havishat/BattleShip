//
//  MPCHandler.swift
//  BattleShip
//
//  Created by havisha tiruvuri on 9/27/17.
//  Copyright © 2017 Thej. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MPCHandler: NSObject, MCSessionDelegate{
    var peerID:MCPeerID!
    var session:MCSession!
    var browser: MCBrowserViewController!
    var advertiser: MCAdvertiserAssistant?  = nil
    
    func setupPeerWithDisplayName (displayName: String){
        peerID = MCPeerID(displayName: displayName)
    }
    
    func setupSession(){
        session = MCSession(peer: peerID)
        session.delegate = self
    }
    
    func setupBrowser(){
        print("hello4")
       browser = MCBrowserViewController(serviceType: "my-game", session: session)
    }
    
    func advertiseSelf(advertise: Bool){
        print("hello3")
        if advertise{
            advertiser = MCAdvertiserAssistant(serviceType: "my-game", discoveryInfo: nil, session: session)
            advertiser!.start()
        } else{
            advertiser!.stop()
            advertiser = nil
        }
    }
    
//    func session(_ session: MCSession!, peer peerID: MCPeerID!, didChange state: MCSessionState) {
//        let userInfo = ["peerID":peerID, "state":state.rawValue] as [String : Any]
//        DispatchQueue.main.async(execute: { () -> Void in
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil, userInfo: userInfo)
//        })
//        
//    }
//    
//    func session(_ session: MCSession!, didReceive data: Data!, fromPeer peerID: MCPeerID!) {
//        let userInfo = ["data": data, "peerId": peerID] as [String : Any]
//        DispatchQueue.main.async(execute: { () -> Void in
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MPC_DidReceiveDataNotification"), object: nil, userInfo: userInfo)
//        })
//    }
    
    
    func session(_ session: MCSession!, peer peerID: MCPeerID!, didChange state: MCSessionState) {
        
      print("====11", state)
        print("====22",peerID)
        print("====33", session)
        
        let userInfo = ["peerID":peerID,"state":state.rawValue] as [String : Any]
        DispatchQueue.main.async(execute: { () -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil, userInfo: userInfo)
        })
    }
    
    func session(_ session: MCSession!, didReceive data: Data!, fromPeer peerID: MCPeerID!) {
        print("====1", data)
        print("====2",peerID)
        print("====3", session)
        let userInfo = ["data":data, "peerID":peerID] as [String : Any]
        DispatchQueue.main.async(execute: { () -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MPC_DidReceiveDataNotification"), object: nil, userInfo: userInfo)
        })
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
    
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    
}
