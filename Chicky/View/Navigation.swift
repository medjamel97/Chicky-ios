//
//  Navigation.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class Navigation: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
    }

}
