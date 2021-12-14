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
    
    
    // Client ID
    /// AbZOlpkgTKqLFADH8P8SyBNlY2sIdI6GS_T3Nb0pz_hMFMZlmBY2l2B1UKLHUAuaSeKg7y5KFO93iws7
    // Secret
    /// EECXO-r3va3xENxMpcXNiCvaCNNHJ1ewVy4nRHHjcl2wg0Ul0vYWowcnqqKb7yzOCQAU9dciGkPYt14s
    
    // tokenation key
    /// sandbox_jyzn55fh_8hsh8cdnn22jr8b5
    
    // variables
    var braintreeClient: BTAPIClient!
    var amount = "50"
    
    // iboutlets
    @IBOutlet weak var frLabel: UILabel!
    @IBOutlet weak var qrImage: UIImageView!
    
    // protocols
    
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frLabel.text = "French".localized() + " language"
        
        braintreeClient = BTAPIClient(authorization: "sandbox_jyzn55fh_8hsh8cdnn22jr8b5")
        
        
        let data = "www.google.com".data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                qrImage.image =  UIImage(ciImage: output)
            }
        }
        
        
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
    
    
    @IBAction func frenchLanguage(_ sender: UISwitch) {
        /*if sender.isOn {
         // Update the language by swaping bundle
         Bundle.setLanguage(Language.getCurrentLanguage())
         // Done to reintantiate the storyboards instantly
         let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
         UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()
         } else {
         UserDefaults.standard.set("en", forKey: "AppleLanguage")
         }*/
        
    }
    
    @IBAction func payPal(_ sender: Any) {
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
                "You have successfuly paid "
                + self.amount
                + " USD using the paypal account : "
                + email!
                
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

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
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
