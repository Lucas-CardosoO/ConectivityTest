//
//  ViewController.swift
//  CuriosityPacMan_iOS
//
//  Created by vinicius emanuel on 27/07/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController {
    
    lazy var peerID = MCPeerID(displayName: UIDevice.current.name)
    lazy var mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .none)
    lazy var mcBrowser = MCBrowserViewController(serviceType: serviceType, session: mcSession)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mcSession.delegate = self
    }
    
    func sendData(direction: String){
        if self.mcSession.connectedPeers.count > 0 {
            let data = direction.data(using: .utf8)!
            do {
                try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
            }catch let error as NSError {
                let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
        }
    }
    
    func conect(){
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    @IBAction func connectPressed(_ sender: Any) {
        self.conect()
    }
    
    @IBAction func leftSwipe(_ sender: Any) {
        self.sendData(direction: "←")
    }
    
    @IBAction func rightSwipe(_ sender: Any) {
        self.sendData(direction: "→")
    }
    
    @IBAction func upSwipe(_ sender: Any) {
        self.sendData(direction: "↑")
    }
    
    @IBAction func downSwipe(_ sender: Any) {
        self.sendData(direction: "↓")
    }
    
    
}

extension ViewController: MCSessionDelegate, MCBrowserViewControllerDelegate{
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            self.sendData(direction: "pegou pegou")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
            
        default:
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
}

