import UIKit

class FavoriteViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tbvCurrencies: UITableView!
    
    var currencyCodes: [(String, String)] = []
    
    public  var currencyFavorite: [clsExchangeRate]!

    let refreashControl = UIRefreshControl()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        refreashControl.addTarget(self, action: #selector(ReLoadData), for: .valueChanged)
        tbvCurrencies.refreshControl = refreashControl
        
        Load()
        

    }
    
    
    func Load()
    {
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

    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        ReLoadData()
    }
    
    
    
    @objc func ReLoadData()
    {
        
        
        let allFavorites = clsExchangeRatesSqLite.fetchRates().filter { $0.IsFavorite == true }

        currencyFavorite = Array(
            Dictionary(grouping: allFavorites, by: { $0.Currency }).compactMap { $0.value.first }
        ).sorted(by: { $0.Currency! < $1.Currency! })
        
        
        if currencyFavorite.isEmpty
        {
            tbvCurrencies.isHidden = true ;
        }
        else
        {
            tbvCurrencies.isHidden = false ;
        }
        
        tbvCurrencies.reloadData()
        refreashControl.endRefreshing()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let favoriteCurrencies = currencyFavorite.count
        return favoriteCurrencies
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyViewCell

        cell.selectionStyle = .none

        let favoriteCurrencies = currencyFavorite
        
        let currencyCode = favoriteCurrencies?[indexPath.row].Currency
        
        let currencyDescription = currencyCodes.first { $0.0 == currencyCode }?.1 ?? "Unknown"
        
        if let rate = currencyFavorite.first(where: { $0.Currency == currencyCode })
        {
            cell.SetCell(Title: currencyCode, Description: currencyDescription, Price: rate.Rate)
        }
        else
        {
            cell.SetCell(Title: currencyCode, Description: currencyDescription, Price: 0.0)
        }
        
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        
        let currencyCode = currencyFavorite[indexPath.row].Currency!
        
        let FavoriteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Delete", comment: "")) { (action, view, completionHandler) in
            
            if clsExchangeRatesSqLite.setFavorite(currencyCode: currencyCode, isFavorite: false)
            {

                clsAlertHelper.showConversionRateError(from: self, Title: NSLocalizedString("Done", comment: ""), Message: "\(currencyCode) " + NSLocalizedString("removed from favorites", comment: ""))
                
                self.ReLoadData()
                tableView.reloadData()
            }
            else
            {
                clsAlertHelper.showConversionRateError(from: self, Title: NSLocalizedString("Delete", comment: ""), Message: "\(currencyCode) " + NSLocalizedString("removed from favorites faild", comment: ""))
            }
            
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [FavoriteAction])
        
    }
    
}
