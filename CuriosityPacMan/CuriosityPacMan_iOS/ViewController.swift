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
    
    // COMUNICACAO
    lazy var peerID = MCPeerID(displayName: UIDevice.current.name)
    lazy var mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .none)
    lazy var mcBrowser = MCBrowserViewController(serviceType: serviceType, session: mcSession)
    
    // UI
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var labelSwipe: UILabel!
    @IBOutlet weak var upImage: UIImageView!
    @IBOutlet weak var downImage: UIImageView!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var buttonConnect: UIButton!
    
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
    
    func connect(){
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    func showArrows(){
        self.buttonConnect.isHidden = true
        self.labelSwipe.isHidden = false
        self.upImage.isHidden = false
        self.downImage.isHidden = false
        self.leftImage.isHidden = false
        self.rightImage.isHidden = false
    }
    
    @IBAction func connectPressed(_ sender: Any) {
        self.connect()
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
            
            DispatchQueue.main.async {
                self.showArrows()
            }
            
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

