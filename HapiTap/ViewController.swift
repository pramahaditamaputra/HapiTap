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
    
    @IBOutlet var toneContainers: [AnimationView]!
    
    @IBOutlet weak var tapHereContainer: AnimationView!
    
    var player: AVAudioPlayer?
    
    var happyBirthdayNoteCounter: Int = 0
    
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
        "ungu"
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
    
    func playSound() {
        
        if happyBirthdayNoteCounter > 25    {
            
            //Reset Song
            happyBirthdayNoteCounter = 0
            
        }else{
            
            print(happyBirthdayNoteCounter)
            
            guard let url = Bundle.main.url(forResource: toneSounds[happyBirthdayNotes[happyBirthdayNoteCounter]], withExtension: "wav", subdirectory: "ToneSound") else { return }
        
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                
                /* iOS 10 and earlier require the following line:
                 player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
                
                guard let player = player else { return }
                
                player.play()
                
                happyBirthdayNoteCounter += 1
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
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
        
        var randomToneBackgroundColor = Int.random(in: 0..<6)
        self.view.backgroundColor = toneBackGroundColor[randomToneBackgroundColor]
        playSound()
        setAnimation()
    }
    
    
    func setAnimation() {
        
        tapHereContainer.isHidden = true
        
        for toneContainer in 0...9 {
            var randomToneContainer = Int.random(in: 0..<32)
            var randomToneColor = Int.random(in: 0..<6)
            toneContainers[randomToneContainer].animation = Animation.named(toneColors[randomToneColor], subdirectory: "ToneColor")
            toneContainers[randomToneContainer].play()
        }
        
    }
    
}

