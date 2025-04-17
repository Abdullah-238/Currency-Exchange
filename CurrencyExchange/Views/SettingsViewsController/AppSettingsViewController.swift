//
//  AppSettingsViewController.swift
//  CurrencyExchange
//
//  Created by Abdullah on 16/10/1446 AH.
//

import UIKit

class AppSettingsViewController: UIViewController
{
    @IBOutlet weak var swtTheme: UISwitch!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let savedTheme = UserDefaults.standard.string(forKey: clsConstant.AppTheme) ?? "system"
            
        swtTheme.isOn = (savedTheme == "dark")
    }
    
    @IBAction func swChangeMode(_ sender: Any)
    {
        guard let switchControl = sender as? UISwitch else { return }
        
        let isDarkMode = switchControl.isOn
        let style: UIUserInterfaceStyle = isDarkMode ? .dark : .light
        let themeString = isDarkMode ? "dark" : "light"
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first
        {
            window.overrideUserInterfaceStyle = style
            UserDefaults.standard.set(themeString, forKey: clsConstant.AppTheme)
        }
        
    }
}
