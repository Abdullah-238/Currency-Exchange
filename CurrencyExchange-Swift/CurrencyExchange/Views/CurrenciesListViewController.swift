import UIKit
import Network
class CurrenciesListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbvCurrencies: UITableView!
    
    @IBOutlet weak var tabFav: UITabBarItem!
    
    var currencyCodes: [(String, String)] = clsCurrencyCodes.currencyCodes
    
    public  var currencyList: [clsExchangeRate]!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        

       Load()
    }
    
    
    func Load()
    {
        currencyList = clsExchangeRatesSqLite.fetchRates()

        if let lang = Locale.current.language.languageCode?.identifier {
            switch lang {
            case "ar":
                currencyCodes = clsCurrencyCodes.currencyCodesAr
            case "en":
                currencyCodes = clsCurrencyCodes.currencyCodesEn
            case "de":
                currencyCodes = clsCurrencyCodes.currencyCodesDe
            case "es":
                currencyCodes = clsCurrencyCodes.currencyCodesEs
            case "fr":
                currencyCodes = clsCurrencyCodes.currencyCodesFr
            case "hi":
                currencyCodes = clsCurrencyCodes.currencyCodesHi
            case "ja":
                currencyCodes = clsCurrencyCodes.currencyCodesJa
            case "pt":
                currencyCodes = clsCurrencyCodes.currencyCodesPt
            case "ru":
                currencyCodes = clsCurrencyCodes.currencyCodesRu
            case "zh-Hans":
                currencyCodes = clsCurrencyCodes.currencyCodesZhHans
            case "zh-Hant":
                currencyCodes = clsCurrencyCodes.currencyCodesZhHant
            default:
                currencyCodes = clsCurrencyCodes.currencyCodes 
            }
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if currencyList != nil
        {
            if !currencyList.isEmpty
            {
                return currencyCodes.count
            }
        }
        
        tbvCurrencies.isHidden = true ;
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyViewCell
        
        cell.selectionStyle = .none

        let currency = currencyCodes[indexPath.row]
        let currencyCode = currency.0
        let currencyDescription = currency.1
                
        if let rate = currencyList.first(where: { $0.Currency == currencyCode })
        {
            cell.SetCell(Title: currencyCode, Description: currencyDescription, Price: rate.Rate)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let currencyCode = currencyCodes[indexPath.row].0

        let favoriteAction = UIContextualAction(style: .normal, title: NSLocalizedString("Favorite", comment: ""))
        { (action, view, completionHandler) in
            
            if !clsExchangeRatesSqLite.isCurrencyFavorite(currencyCode: currencyCode)
            {
                
                if clsExchangeRatesSqLite.setFavorite(currencyCode: currencyCode, isFavorite: true)
                {
                    clsAlertHelper.showConversionRateError(from: self, Title: NSLocalizedString("Done", comment: ""), Message: "\(currencyCode) " + NSLocalizedString("added to favorites", comment: ""))
                }
            }
            else
            {
                
                clsAlertHelper.showConversionRateError(from: self, Title: NSLocalizedString("Error", comment: ""), Message:  "\(currencyCode) " +  NSLocalizedString("is already added to favorites", comment: ""))
            }
            
            completionHandler(true)
        }

        favoriteAction.backgroundColor = .systemYellow

        return UISwipeActionsConfiguration(actions: [favoriteAction])

    }
    
   
    
}

    
    

