//
//  ViewController.swift
//  HapiTap
//
//  Created by Pramahadi Tama Putra on 17/05/19.
//  Copyright © 2019 Pramahadi Tama Putra. All rights reserved.
//

import UIKit
import Lottie
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mainToneContainers: AnimationView!
    @IBOutlet var toneContainers: [AnimationView]!
    
    @IBOutlet weak var tapHereContainer: AnimationView!
    
    var player: AVAudioPlayer?

    var happyBirthdayNoteCounter: Int = 0
    var tapColorCounter: Int = 0
    var tapSparkleCounter: Int = 0
    
    var happyBirthdayNotes: [Int] = [
        4,4,5,4,0,6,
        4,4,5,4,1,0,
        4,4,4,2,0,0,6,5,
        3,3,2,0,1,0
    ]
    
    var toneBackGroundColor: [UIColor] = [
        #colorLiteral(red: 0.003921568627, green: 0.7450980392, blue: 0.9960784314, alpha: 1),
        #colorLiteral(red: 1, green: 0.8666666667, blue: 0, alpha: 1),
        #colorLiteral(red: 1, green: 0.4901960784, blue: 0, alpha: 1),
        #colorLiteral(red: 1, green: 0, blue: 0.4274509804, alpha: 1),
        #colorLiteral(red: 0.6784313725, green: 1, blue: 0.007843137255, alpha: 1),
        #colorLiteral(red: 0.5607843137, green: 0, blue: 1, alpha: 1)
    ]
    
    var toneColors: [String] = [
        "biru",
        "hijau",
        "kuning",
        "oren",
        "pink",
        "ungu",
        "sparkleHappy"
    ]
    
    var toneSounds: [String] = [
        "do",
        "re",
        "mi",
        "fa",
        "sol",
        "la",
        "si",
        "doo"
    ]
    
    var tapToneSounds: [String] = [
        "bubbles",
        "clay",
        "confetti",
        "corona",
        "dotted-spiral",
        "flash-1",
        "flash-2",
        "flash-3",
        "glimmer",
        "moon",
        "pinwheel",
        "piston-1",
        "piston-2",
        "piston-3",
        "prism-1",
        "prism-2",
        "prism-3",
        "splits",
        "squiggle",
        "strike",
        "suspension",
        "timer",
        "ufo",
        "veil",
        "wipe",
        "zig-zag"
    ]
    
    func playSound() {
        
//        if happyBirthdayNoteCounter > 25    {
        
            //Reset Song
//            happyBirthdayNoteCounter = 0
            
//        }else{
            
//            print(happyBirthdayNoteCounter)
        
        var randomTapToneSoundNumber: Int = Int.random(in: 0...25)
        
            guard let url = Bundle.main.url(forResource: tapToneSounds[randomTapToneSoundNumber], withExtension: "mp3", subdirectory: "TapToneSound") else { return }
        
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                
                /* iOS 10 and earlier require the following line:
                 player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
                
                guard let player = player else { return }
                
                player.play()
                
//                happyBirthdayNoteCounter += 1
                
            } catch let error {
                print(error.localizedDescription)
            }
//        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tapHereSetAnimation()
    }
    
    func tapHereSetAnimation(){
        tapHereContainer.animation = Animation.named("tapHere")
        tapHereContainer.loopMode = .loop
        tapHereContainer.play()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tapColorCounter += 1
        var randomScale: Int = Int.random(in: 1...10)
        var randomMainTapToneContainer: Int = Int.random(in: 0..<6)
        
        if let touch = touches.first {
            let position = touch.location(in: view)
            UIView.animate(withDuration: 0.1) {
                if self.tapColorCounter < 10 {
                    self.mainToneContainers.animation = Animation.named(self.toneColors[randomMainTapToneContainer], subdirectory: "ToneColor")
                }else{
                    self.tapSparkleCounter += 1
                    self.mainToneContainers.animation = Animation.named(self.toneColors[6], subdirectory: "ToneColor")
                    
                    if self.tapSparkleCounter > 10 {
                        self.tapColorCounter = 0
                        self.tapSparkleCounter = 0
                    }
                }
                self.mainToneContainers.center = CGPoint(x: position.x, y: position.y)
                self.mainToneContainers.transform = CGAffineTransform(scaleX: CGFloat(randomScale), y: CGFloat(randomScale))
                self.mainToneContainers.play()
            }
        }
        
        playSound()
        setAnimation()
    }
    
    
    func setAnimation() {
        
        tapHereContainer.isHidden = true
        
//        for toneContainer in 0...1 {
            var randomToneBackgroundColor = Int.random(in: 0..<6)
            var randomToneContainer = Int.random(in: 0..<32)
            var randomToneColor = Int.random(in: 0..<6)
            var randomSizeX = Int.random(in: 1...3)
            var randomSizeY = Int.random(in: 1...3)

            UIView.animate(withDuration: 0.1, animations: {
//                self.view.backgroundColor = self.toneBackGroundColor[randomToneBackgroundColor]
                if self.tapColorCounter < 10 {
                    self.toneContainers[randomToneContainer].animation = Animation.named(self.toneColors[randomToneColor], subdirectory: "ToneColor")
                }else{
                    self.toneContainers[randomToneContainer].animation = Animation.named(self.toneColors[6], subdirectory: "ToneColor")
                }
                self.toneContainers[randomToneContainer].transform = CGAffineTransform(scaleX: CGFloat(randomSizeX), y: CGFloat(randomSizeX))
                self.toneContainers[randomToneContainer].play()
            })
//        }
        
    }
    
}

