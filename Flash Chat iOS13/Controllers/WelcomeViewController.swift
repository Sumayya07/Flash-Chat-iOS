//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by saeem  on 28/02/22.
//  Copyright © 2022 Saeem. All rights reserved.
//

import UIKit


class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        titleLabel.text = ""

        var charIndex = 0.0 // This variable is helping us to change the timer interval so that it take accounts a delay for every subsequest letter.
        let titleText = K.appName
        for letter in titleText { // This is a for loop
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (Timer) in
                self.titleLabel.text?.append(letter) // For every letter in the title text Timer property schedules a timer that waits for 0.1 second and then it adds the letter to our titlelabel.text.
            }
            charIndex += 1
            // THE ABOVE CODE IS HELPING US TO CREATE A TYPING ANIMATION WHEN THE USER OPENS THE APP.

        }

       
    }
    

}
