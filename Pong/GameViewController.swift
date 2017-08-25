//
//  GameViewController.swift
//  Pong
//
//  Created by Alejandro on 28/05/17.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

var currentGameType = gameType.medium


class GameViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "pongo", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                scene.size = view.bounds.size
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        audioPlayer.play()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func back(_ sender: Any) {
        audioPlayer.play()
    }
    @IBAction func pause(_ sender: Any) {
        if audioPlayer.isPlaying{
            audioPlayer.pause()
        }else{
            
        }
    }
    
    @IBAction func restart(_ sender: Any) {
        
    
        if audioPlayer.isPlaying{
            
            audioPlayer.currentTime = 0
            audioPlayer.play()
            
            
        }else{
            audioPlayer.play()
        }

    }
    
    @IBAction func Atras(_ sender: Any) {
        audioPlayer.stop()
    }
    
}
