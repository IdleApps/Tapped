//
//  TutorialViewController.swift
//  Tapped
//
//  Created by Luke Cheskin on 24/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func finishTutorialAction(_ sender: Any) {
        
        print("The user has successfully finished the tutorial.")
        
        UserDefaults.standard.set("true", forKey: "hasFinishedTutorial")
        
    }

}
