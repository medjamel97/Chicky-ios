//
//  SettingsView.swift
//  Chicky
//
//  Created by Apple Mac on 14/12/2021.
//

import Foundation
import UIKit

class SettingsView: UIViewController {
    
    
    
    // iboutlets
    
    // protocols
    
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // ACTIONS
    @IBAction func switchTheme(_ sender: UISwitch) {
        if sender.isOn {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    @IBAction func payPal(_ sender: Any) {
       /// paypalAction(amount: "1")
    }
    
    @IBAction func payPal2(_ sender: Any) {
     ///   paypalAction(amount: "10")
    }
    
    @IBAction func payPal3(_ sender: Any) {
       //// paypalAction(amount: "100")
    }
}
