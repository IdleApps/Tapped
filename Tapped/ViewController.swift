//
//  ViewController.swift
//  Tapped
//
//  Created by Luke Cheskin on 12/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation

class ViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet var bannerViewAdvert: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if UserDefaults.standard.value(forKey: "hasFinishedTutorial") == nil {
            print("The user has not yet looked at the tutorial screen. Presenting..")
            self.perform(#selector(presentTutorialScreen), with: nil, afterDelay: 0)
            return
        }
        
        if musicIsStopped == true {
            GSAudio.sharedInstance.playSound(soundFileName: "Soundtrack")
        }
        
        if UserDefaults.standard.value(forKey: "team1BackgroundColour") as? String == nil {
            // No background colour for team 1 was found.
            UserDefaults.standard.set("Red", forKey: "team1BackgroundColour")
            print("No background colour for team 1 found. Setting to default (Red)")
        }
        
        if UserDefaults.standard.value(forKey: "team2BackgroundColour") as? String == nil {
            // No background colour for team 2 was found.
            UserDefaults.standard.set("Blue", forKey: "team2BackgroundColour")
            print("No background colour for team 2 found. Setting to default (Blue)")
        }
        
        if UserDefaults.standard.value(forKey: "winValue") as? String == nil {
            // No win value was found.
            UserDefaults.standard.set("9", forKey: "winValue")
            print("No winning value found. Setting to default (10)")
        }
        
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
    
    
    @IBAction func soundStateChanged(_ sender: Any) {
        
        print("Sound state changed")
        GSAudio.sharedInstance.playSound(soundFileName: "Pop")
        
    }
    
    func presentTutorialScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Tutorial") as UIViewController
        present(vc, animated: true)
    }
    
}
