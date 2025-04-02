import UIKit

class CurrenciesListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbvCurrencies: UITableView!
    
    let currencyCodes: [(String, String)] = [
        ("AED", "United Arab Emirates Dirham"),
        ("ARS", "Argentine Peso"),
        ("AUD", "Australian Dollar"),
        ("BGN", "Bulgarian Lev"),
        ("BRL", "Brazilian Real"),
        ("BSD", "Bahamian Dollar"),
        ("CAD", "Canadian Dollar"),
        ("CHF", "Swiss Franc"),
        ("CLP", "Chilean Peso"),
        ("CNY", "Chinese Yuan"),
        ("COP", "Colombian Peso"),
        ("CZK", "Czech Koruna"),
        ("DKK", "Danish Krone"),
        ("DOP", "Dominican Peso"),
        ("EGP", "Egyptian Pound"),
        ("EUR", "Euro"),
        ("FJD", "Fijian Dollar"),
        ("GBP", "British Pound Sterling"),
        ("GTQ", "Guatemalan Quetzal"),
        ("HKD", "Hong Kong Dollar"),
        ("HRK", "Croatian Kuna"),
        ("HUF", "Hungarian Forint"),
        ("IDR", "Indonesian Rupiah"),
        ("ILS", "Israeli New Shekel"),
        ("INR", "Indian Rupee"),
        ("ISK", "Icelandic Króna"),
        ("JPY", "Japanese Yen"),
        ("KRW", "South Korean Won"),
        ("KZT", "Kazakhstani Tenge"),
        ("MXN", "Mexican Peso"),
        ("MYR", "Malaysian Ringgit"),
        ("NOK", "Norwegian Krone"),
        ("NZD", "New Zealand Dollar"),
        ("PAB", "Panamanian Balboa"),
        ("PEN", "Peruvian Nuevo Sol"),
        ("PHP", "Philippine Peso"),
        ("PKR", "Pakistani Rupee"),
        ("PLN", "Polish Zloty"),
        ("PYG", "Paraguayan Guarani"),
        ("RON", "Romanian Leu"),
        ("RUB", "Russian Ruble"),
        ("SAR", "Saudi Riyal"),
        ("SEK", "Swedish Krona"),
        ("SGD", "Singapore Dollar"),
        ("THB", "Thai Baht"),
        ("TRY", "Turkish Lira"),
        ("TWD", "New Taiwan Dollar"),
        ("UAH", "Ukrainian Hryvnia"),
        ("USD", "United States Dollar"),
        ("UYU", "Uruguayan Peso"),
        ("ZAR", "South African Rand")
    ]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tbvCurrencies.delegate = self
        tbvCurrencies.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return currencyCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyViewCell
        
        
        let currency = currencyCodes[indexPath.row]
        let currencyCode = currency.0
        let currencyDescription = currency.1
        if let price = clsGlobal.currencyConverter.objResponse?.conversion_rates[currencyCode] {
                   cell.SetCell(Title: currencyCode, Description: currencyDescription, Price: price)
               }
    else
        {
                   cell.SetCell(Title: currencyCode, Description: currencyDescription, Price: 0.0)
               }
        
    
        return cell
    }
    
}
