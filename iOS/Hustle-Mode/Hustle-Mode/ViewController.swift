//
//  ViewController.swift
//  Hustle-Mode
//
//  Created by Robert Choe on 12/24/17.
//  Copyright © 2017 Robert Choe. All rights reserved.
//

import UIKit
/*allows us to play music*/
import AVFoundation
class ViewController: UIViewController {

    /*here, all we are doing is linking our buttons, pictures, and screens to our code
      this way we can create functions to display certain things*/
    @IBOutlet weak var darkBlueBG: UIImageView!
    @IBOutlet weak var powerButton: UIButton!
    @IBOutlet weak var cloudHolder: UIView!
    @IBOutlet weak var rocket: UIImageView!
    @IBOutlet weak var hustleLabel: UILabel!
    @IBOutlet weak var onLabel: UILabel!
    
    var player: AVAudioPlayer! //created a varibale called "player" that allows us to play an audio file
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*This loads the audio file into our player varibale. It sets to to prepareToPlay(), that way when we can use player.play() to play the audio file*/
        let path = Bundle.main.path(forResource: "hustle-on", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
    }

    /*here, we linked the power button to our code, but with the "action" option on. This creates a function we can tell what to do when the function is called*/
    @IBAction func powerButtonPressed(_ sender: Any) {
        //We want to hide everything on first page
        darkBlueBG.isHidden = true
        powerButton.isHidden = true
        
        //show everything on second page
        cloudHolder.isHidden = false
        
        player.play() //plays the sound effect
        
        /*UIView.animate() is used to animate things. The "finsihed" part is used to tell the interface what to do after the animation is done. IN this case it displays two text labels. Hustle and on.*/
        UIView.animate(withDuration: 2.3, animations: {
            self.rocket.frame = CGRect(x: 0, y: 150, width: 385, height: 335)
        }) { (finsihed) in
            self.hustleLabel.isHidden = false
            self.onLabel.isHidden = false
            
        }
        
        
    }
    

}

