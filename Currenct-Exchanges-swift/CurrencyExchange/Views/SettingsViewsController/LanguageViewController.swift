//
//  LanguageViewController.swift
//  CurrencyExchange
//
//  Created by Abdullah on 16/10/1446 AH.
//

import UIKit

class LanguageViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource
{

    @IBOutlet weak var pkvLanguages: UIPickerView!
    
    var selectedLanguageIndex = 0
    
    var selectedLanguageCode: [(code: String, name: String)]!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        tabBarItem.isEnabled = false
        
        pkvLanguages.delegate = self
        pkvLanguages.dataSource = self
        
       // Load()
        
        selectedLanguageCode = clsLanguage.languages
        
    }
    
    func Load() {
        if let lang = Locale.current.language.languageCode?.identifier {
            switch lang {
            case "ar":
                selectedLanguageCode = clsLanguage.languagesAr
            case "en":
                selectedLanguageCode = clsLanguage.languagesEn
            case "de":
                selectedLanguageCode = clsLanguage.languagesDe
            case "es":
                selectedLanguageCode = clsLanguage.languagesEs
            case "fr":
                selectedLanguageCode = clsLanguage.languagesFr
            case "hi":
                selectedLanguageCode = clsLanguage.languagesHi
            case "ja":
                selectedLanguageCode = clsLanguage.languagesJa
            case "pt":
                selectedLanguageCode = clsLanguage.languagesPt
            case "ru":
                selectedLanguageCode = clsLanguage.languagesRu
            case "zh-Hans":
                selectedLanguageCode = clsLanguage.languagesZhHans
            case "zh-Hant":
                selectedLanguageCode = clsLanguage.languagesZhHant
            default:
                selectedLanguageCode = clsLanguage.languagesEn
            }
        }
    }

    
    
    @IBAction func btnChangeLanguage(_ sender: Any)
    {
        let selectedCode = selectedLanguageCode[selectedLanguageIndex].code
        UserDefaults.standard.set([selectedCode], forKey: "AppleLanguages")
        
        clsAlertHelper.showConversionRateError(from: self, Title: NSLocalizedString("Waring", comment: "Waring"), Message: NSLocalizedString("Please re-start the application to apply the changes", comment: ""))
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        selectedLanguageCode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return selectedLanguageCode[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedLanguageIndex = row
    }

    
}
