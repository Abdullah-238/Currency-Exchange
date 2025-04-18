//
//  AboutViewController.swift
//  CurrencyExchange
//
//  Created by Abdullah on 17/10/1446 AH.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var txtvAboutUs: UITextView!
    
    @IBOutlet weak var lblVersion: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        lblVersion.text =  Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

        txtvAboutUs.text = NSLocalizedString("About The App", comment: "")
        
    }
    
  

}
