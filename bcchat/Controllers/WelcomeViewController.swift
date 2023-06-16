//
//  WelcomeViewController.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-08.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "⚡️bcChat"
        for letter in titleText {
            //in order to schedule timers to start differently, we can deley the subsequecial timer by multiplying a charIndex
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { Timer in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
        if let secrectKey = Bundle.main.infoDictionary?["secretKey"] as? String {
            print(secrectKey)
        }

    }
    
}
