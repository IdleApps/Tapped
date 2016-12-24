//
//  GameViewController.swift
//  Tapped
//
//  Created by Luke Cheskin on 12/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet var timeStampLabel: UILabel!
    @IBOutlet var bannerViewAdvert: GADBannerView!
    @IBOutlet var restartGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        restartGameButton.isHidden = true // Ignore this line
        
        timeStampLabel.text! = "Are you ready?"
        startTimer()
        
        if UserDefaults.standard.bool(forKey: "com.IdleApps.Tapped.RemovingAds") == true {
            // The user has payed to remove ads.
            print("User has purchased Remove Ads. Removing..")
            bannerViewAdvert.isHidden = true
        } else {
            // The user has not payed to remove ads.
            print("User has not purchased Remove Ads. Displaying..")
            let request = GADRequest()
            request.testDevices = [kGADSimulatorID, "ca-app-pub-8403640993517419/6755607485"]
            bannerViewAdvert.delegate = self
            bannerViewAdvert.adUnitID = "ca-app-pub-8403640993517419/6755607485"
            bannerViewAdvert.rootViewController = self
            bannerViewAdvert.load(request)
            bannerViewAdvert.isHidden = false
        }
        
    }
    
    func startTimer() {
        
        // Countdown until the game starts. (3,2,1)
        
        let seconds3Left = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: seconds3Left) { // Activates after 1 second.
            // Displays "3"
            self.timeStampLabel.text! = "3"
        }
        
        let seconds2Left = DispatchTime.now() + 2.0
        DispatchQueue.main.asyncAfter(deadline: seconds2Left) { // Activates after 2 seconds.
            // Displays "2"
            self.timeStampLabel.text! = "2"
        }
        
        let seconds1Left = DispatchTime.now() + 3.0
        DispatchQueue.main.asyncAfter(deadline: seconds1Left) { // Activates after 3 seconds.
            // Displays "1"
            self.timeStampLabel.text! = "1"
        }
        
        let secondsGOLeft = DispatchTime.now() + 4.0
        DispatchQueue.main.asyncAfter(deadline: secondsGOLeft) { // Activates after 4 seconds.
            // Displays "GO!"
            self.timeStampLabel.text! = "GO!"
        }
        
        let secondsStartLeft = DispatchTime.now() + 5.0
        DispatchQueue.main.asyncAfter(deadline: secondsStartLeft) { // Activates after 5 seconds.
            // Presents the game view controller to the user.
            self.timeStampLabel.isHidden = true // Hides the time stamp.
            self.present(self.storyboard!.instantiateViewController(withIdentifier: "TappedViewController") as UIViewController, animated: true, completion: nil)
            
        }
        
    }
    
    

}
