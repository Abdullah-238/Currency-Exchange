//
//  SettingsViewController.swift
//  CurrencyExchange
//
//  Created by Abdullah on 15/10/1446 AH.
//

import UIKit

class SettingsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblVersion: UILabel!
    
    enum SettingType
    {
        case settings
        case language
        case notifications
        case about
        case rateUs
    }

    struct Settings
    {
        var Image : String
        var Title : String
        var Description : String
        let type: SettingType
    }

    @IBOutlet weak var tbvSettings: UITableView!
    
    var arrSettings : [Settings] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        tbvSettings.dataSource = self
        tbvSettings.delegate = self
        
        Load()
        
    }
    
    func Load() {
        arrSettings = [
            Settings(
                Image: "gear",
                Title: NSLocalizedString("Settings", comment: "Settings title"),
                Description: NSLocalizedString("App configuration options", comment: "Settings description"),
                type: .settings
            ),
            Settings(
                Image: "globe",
                Title: NSLocalizedString("Language", comment: "Language title"),
                Description: NSLocalizedString("Change app language", comment: "Language description"),
                type: .language
            ),
            Settings(
                Image: "bell",
                Title: NSLocalizedString("Notifications", comment: "Notifications title"),
                Description: NSLocalizedString("Manage notification preferences", comment: "Notifications description"),
                type: .notifications
            ),
            Settings(
                Image: "info.circle",
                Title: NSLocalizedString("About", comment: "About title"),
                Description: NSLocalizedString("App version and information", comment: "About description"),
                type: .about
            ),
            Settings(
                Image: "star",
                Title: NSLocalizedString("Rate Us", comment: "Rate Us title"),
                Description: NSLocalizedString("Leave a review on the App Store", comment: "Rate Us description"),
                type: .rateUs
            )
        ]
        
        tbvSettings.reloadData()
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "settingsCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingsViewCell
        
        let setting = arrSettings[indexPath.row]
        let image = UIImage(systemName: setting.Image)
        cell.SetCell(Title: setting.Title, Description: setting.Description, Image: image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let setting = arrSettings[indexPath.row]

        switch setting.type
        {
        case .settings:
            let vc = self.storyboard?.instantiateViewController(identifier: "SettingsView")
            navigationController?.pushViewController(vc!, animated: true)
            break ;

        case .language:
            let vc = self.storyboard?.instantiateViewController(identifier: "LanguageView")
            navigationController?.pushViewController(vc!, animated: true)
            break ;
            

        case .notifications: break
         //   let vc = NotificationsViewController()
         //   navigationController?.pushViewController(vc, animated: true)

        case .about:
            let vc = self.storyboard?.instantiateViewController(identifier: "AboutusView")
            navigationController?.pushViewController(vc!, animated: true)
            break ;

        case .rateUs:break
          //  if let url = URL(string: "itms-apps://itunes.apple.com/app/idYOUR_APP_ID?action=write-review"),
          //     UIApplication.shared.canOpenURL(url)
          //  {
          //      UIApplication.shared.open(url, options: [:], completionHandler: nil)
          //  }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }


  

}
