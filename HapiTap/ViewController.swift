//
//  ViewController.swift
//  HapiTap
//
//  Created by Pramahadi Tama Putra on 17/05/19.
//  Copyright © 2019 Pramahadi Tama Putra. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    var counterTouch = 0
    var counterNot = 0
    
    var notTwinkleLittleStar: [Int] = [
        0,0,4,4,5,5,4,
        3,3,2,2,1,1,0,
        4,4,3,3,2,2,1,
        4,4,3,3,2,2,1,
        0,0,4,4,5,5,4,
        3,3,2,2,1,1,0
    ]
    
    var toneNotasiAngka: [String] = [
        "do",
        "re",
        "mi",
        "fa",
        "sol",
        "la",
        "si"
    ]
    
    var toneBackGroundColor: [CGColor] = [
        #colorLiteral(red: 0.003921568627, green: 0.7450980392, blue: 0.9960784314, alpha: 1),
        #colorLiteral(red: 1, green: 0.8666666667, blue: 0, alpha: 1),
        #colorLiteral(red: 1, green: 0.4901960784, blue: 0, alpha: 1),
        #colorLiteral(red: 0.5607843137, green: 0, blue: 1, alpha: 1),
        #colorLiteral(red: 0.6784313725, green: 1, blue: 0.007843137255, alpha: 1),
    ]
    
    var toneViewBackgroundColor: [CGColor] = [
        #colorLiteral(red: 0.3294117647, green: 1, blue: 0.9843137255, alpha: 1),
        #colorLiteral(red: 1, green: 0.9176470588, blue: 0.4235294118, alpha: 1),
        #colorLiteral(red: 1, green: 0.6039215686, blue: 0.3333333333, alpha: 1),
        #colorLiteral(red: 0.9058823529, green: 0.6980392157, blue: 1, alpha: 1),
        #colorLiteral(red: 0.537254902, green: 1, blue: 0.8, alpha: 1),
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
    
    
    
    
    @IBOutlet weak var mainToneContainers: UIView!
    @IBOutlet var toneContainers: [UIView]!
    @IBOutlet weak var startContainer: UIView!
    @IBOutlet weak var startTapLabel: UILabel!
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func startGameAnimation() {
        let randomColor1 = Int.random(in: 0...4)
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.startContainer.transform = CGAffineTransform(scaleX: CGFloat(1), y: CGFloat(1))
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                self.startContainer.layer.backgroundColor = self.toneBackGroundColor[randomColor1]
                let positionView = self.startContainer.center
                let pulse = PulseAnimation(numberOfPulses: 5, radius: CGFloat(100), position: positionView)
                pulse.backgroundColor = self.toneBackGroundColor[randomColor1]
                pulse.animationDuration = 0.2
                self.view.layer.insertSublayer(pulse, below: self.startContainer.layer)
            })
        }
    }
    
    func setBeginingShapeState() {
        // Do any additional setup after loading the view.
        mainToneContainers.layer.opacity = 0
        mainToneContainers.layer.cornerRadius = mainToneContainers.frame.width/2
        startContainer.layer.cornerRadius = startContainer.frame.width/2
        for toneContainer in toneContainers {
            toneContainer.layer.opacity = 0
            toneContainer.layer.cornerRadius = toneContainer.frame.width/2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBeginingShapeState()
        startGameAnimation()
    }
    
    func toneContainersAnimation(_ randomCircle: Int, _ randomScale2: Int, _ randomColor2: Int, _ randomRadius2: Int) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.toneContainers[randomCircle].transform = CGAffineTransform(scaleX: CGFloat(randomScale2), y: CGFloat(randomScale2))
            self.toneContainers[randomCircle].layer.opacity = 1
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                self.toneContainers[randomCircle].layer.backgroundColor = self.toneBackGroundColor[randomColor2]
                let positionView = self.toneContainers[randomCircle].center
                let pulse = PulseAnimation(numberOfPulses: 1, radius: CGFloat(randomRadius2), position: positionView)
                pulse.backgroundColor = self.toneBackGroundColor[randomColor2]
                pulse.animationDuration = 1
                self.view.layer.insertSublayer(pulse, below: self.toneContainers[randomCircle].layer)
                self.toneContainers[randomCircle].transform = .identity
                self.toneContainers[randomCircle].layer.opacity = 0
            })
        }
    }
    
    func mainToneContainersAnimation(_ position: CGPoint, _ randomScale1: Int, _ randomColor1: Int, _ randomRadius1: Int) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            
            
            
            if self.counterTouch >= 0 && self.counterTouch <= 6 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[0]
            }else if self.counterTouch > 6 && self.counterTouch <= 13 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[1]
            }else if self.counterTouch > 13 && self.counterTouch <= 20 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[2]
            }else if self.counterTouch > 20 && self.counterTouch <= 27 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[3]
            }else if self.counterTouch > 27 && self.counterTouch <= 34 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[4]
            }else if self.counterTouch > 34 && self.counterTouch <= 41 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[1]
            }
            
            self.startContainer.isHidden = true
            self.startTapLabel.isHidden = true
            self.mainToneContainers.center = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
            self.mainToneContainers.transform = CGAffineTransform(scaleX: CGFloat(randomScale1), y: CGFloat(randomScale1))
            self.mainToneContainers.layer.opacity = 1
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                self.mainToneContainers.layer.backgroundColor = self.toneBackGroundColor[randomColor1]
                let positionView = self.mainToneContainers.center
                let pulse = PulseAnimation(numberOfPulses: 1, radius: CGFloat(randomRadius1), position: positionView)
                pulse.backgroundColor = self.toneBackGroundColor[randomColor1]
                pulse.animationDuration = 1
                self.view.layer.insertSublayer(pulse, below: self.mainToneContainers.layer)
                self.mainToneContainers.transform = .identity
                self.mainToneContainers.layer.opacity = 0
            })
        }
    }
    
    func playSound() {
//        var randomTapToneSoundNumber: Int = Int.random(in: 0...25)
//        print(notTwinkleLittleStar.count)
        
        if counterNot <= 41 {
        
            guard let url = Bundle.main.url(forResource: toneNotasiAngka[notTwinkleLittleStar[counterNot]], withExtension: "wav", subdirectory: "ToneSound") else { return }
        
//        guard let url = Bundle.main.url(forResource: tapToneSounds[randomTapToneSoundNumber], withExtension: "mp3", subdirectory: "A") else { return }
        
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                
                /* iOS 10 and earlier require the following line:
                 player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
                
                guard let player = player else { return }
                
                player.play()
                
                
            } catch let error {
                print(error.localizedDescription)
            }
            
            counterNot+=1
            counterTouch += 1
        }else if counterNot > 41{
            counterNot = 0
            counterTouch = 0
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        print(self.counterTouch)
        print(self.counterNot)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        playSound()
        let randomScale1 = Int.random(in: 1...5)
        let randomRadius1 = Int.random(in: 250...300)
        let randomScale2 = Int.random(in: 1...2)
        let randomRadius2 = Int.random(in: 150...200)
        let randomColor1 = Int.random(in: 0...4)
        let randomColor2 = Int.random(in: 0...4)
        let randomCircle = Int.random(in: 0...31)
        if let touch = touches.first {
            let position = touch.location(in: view)
            mainToneContainersAnimation(position, randomScale1, randomColor1, randomRadius1)
            toneContainersAnimation(randomCircle, randomScale2, randomColor2, randomRadius2)
        }
    }
}

