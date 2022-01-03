//
//  SettingsView.swift
//  Chicky
//
//  Created by Apple Mac on 14/12/2021.
//

import Foundation
import UIKit
import Braintree

class SettingsView: UIViewController {
    
    // Buyer paypal sandbox account
    // Email ID:
    /// sb-sptpo9118929@personal.example.com
    // System Generated Password:
    /// *J+w07sT
    ///
    /// seller acc : sb-bu6xz9108844@business.example.com
    
    
    // Client ID
    /// AbZOlpkgTKqLFADH8P8SyBNlY2sIdI6GS_T3Nb0pz_hMFMZlmBY2l2B1UKLHUAuaSeKg7y5KFO93iws7
    // Secret
    /// EECXO-r3va3xENxMpcXNiCvaCNNHJ1ewVy4nRHHjcl2wg0Ul0vYWowcnqqKb7yzOCQAU9dciGkPYt14s
    
    // tokenation key
    /// sandbox_jyzn55fh_8hsh8cdnn22jr8b5
    
    // variables
    var braintreeClient: BTAPIClient!
    
    // iboutlets
    
    // protocols
    
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        braintreeClient = BTAPIClient(authorization: "sandbox_jyzn55fh_8hsh8cdnn22jr8b5")
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
        paypalAction(amount: "1")
    }
    
    @IBAction func payPal2(_ sender: Any) {
        paypalAction(amount: "10")
    }
    
    @IBAction func payPal3(_ sender: Any) {
        paypalAction(amount: "100")
    }
    
    func paypalAction(amount: String) {
        if braintreeClient != nil {
            let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
            payPalDriver.viewControllerPresentingDelegate = self
            payPalDriver.appSwitchDelegate = self // Optional
            
            // Specify the transaction amount here. "2.32" is used in this example.
            let request = BTPayPalRequest(amount: amount)
            request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options
            
            payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                    print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                    
                    // Access additional information
                    
                    let email = tokenizedPayPalAccount.email
                    
                    /*let firstName = tokenizedPayPalAccount.firstName
                     let lastName = tokenizedPayPalAccount.lastName
                     let phone = tokenizedPayPalAccount.phone
                     See BTPostalAddress.h for details
                     let billingAddress = tokenizedPayPalAccount.billingAddress
                     let shippingAddress = tokenizedPayPalAccount.shippingAddress*/
                    
                    
                    let message =
                    "You have successfuly donated "
                    + amount
                    + "$, Tank you"
                    
                    self.present(Alert.makeActionAlert(titre: "Success", message:  message, action: UIAlertAction(title: "Ok", style: .default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    })),animated: true)
                } else if let error = error {
                    print(error)
                } else {
                    // Buyer canceled payment approval
                }
            }
        }
    }
}

extension SettingsView : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
}

extension SettingsView : BTAppSwitchDelegate{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
}
