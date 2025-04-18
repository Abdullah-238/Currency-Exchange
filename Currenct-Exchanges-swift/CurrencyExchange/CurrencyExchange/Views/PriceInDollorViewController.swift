

import UIKit

class PriceInDollorViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{

    var CurrencyCodes: [String] =
    [
        "AED", "ARS", "AUD", "BGN", "BRL", "BSD", "CAD", "CHF", "CLP", "CNY",
        "COP", "CZK", "DKK", "DOP", "EGP", "EUR", "FJD", "GBP", "GTQ", "HKD",
        "HRK", "HUF", "IDR", "ILS", "INR", "ISK", "JPY", "KRW", "KZT", "MXN",
        "MYR", "NOK", "NZD", "PAB", "PEN", "PHP", "PKR", "PLN", "PYG", "RON",
        "RUB", "SAR", "SEK", "SGD", "THB", "TRY", "TWD", "UAH", "USD", "UYU", "ZAR"
    ]
    
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var pkCurrencies: UIPickerView!
    
    var Currency: String!
    
    var obj : clsCurrencyConverter!

    override func viewDidLoad() {
        super.viewDidLoad()

        Load()
    }
    
    func Load()
    {
        
        pkCurrencies.delegate = self
        pkCurrencies.delegate = self
        
        pkCurrencies.selectRow(48, inComponent: 0, animated: false)
        Currency = CurrencyCodes[41]
        
        obj = clsGlobal.currencyConverter
        
        
        pickerView(pkCurrencies, didSelectRow: 48, inComponent: 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyCodes.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return CurrencyCodes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let selectedCurrency = CurrencyCodes[row]
        
        if let rates = obj.objResponse?.conversion_rates, let rate = rates[selectedCurrency]
        {
            txtAmount.text = String(rate)
        } else
        {
            clsAlertHelper.showConversionRateError(from: self)
        }
    }

  

}
