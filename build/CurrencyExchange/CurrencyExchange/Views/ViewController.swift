
import Foundation
import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate
{
    var baseCurrency: String!
    var targetCurrency: String!
    var CurrencyCodes: [String] =
    [
        "AED", "ARS", "AUD", "BGN", "BRL", "BSD", "CAD", "CHF", "CLP", "CNY",
        "COP", "CZK", "DKK", "DOP", "EGP", "EUR", "FJD", "GBP", "GTQ", "HKD",
        "HRK", "HUF", "IDR", "ILS", "INR", "ISK", "JPY", "KRW", "KZT", "MXN",
        "MYR", "NOK", "NZD", "PAB", "PEN", "PHP", "PKR", "PLN", "PYG", "RON",
        "RUB", "SAR", "SEK", "SGD", "THB", "TRY", "TWD", "UAH", "USD", "UYU", "ZAR"
    ]
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var pkCurrencyFrom: UIPickerView!
    @IBOutlet weak var pkCurrencyTo: UIPickerView!
    
    var obj : clsCurrencyConverter!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Load()
        
       
    }
    
    func Load()
    {
        self.txtAmount.delegate = self

        pkCurrencyFrom.delegate = self
        pkCurrencyTo.delegate = self
        
        pkCurrencyTo.dataSource = self
        pkCurrencyFrom.dataSource = self
        
        setDefaultCurrencySelection()
        
        obj = clsGlobal.currencyConverter
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          view.addGestureRecognizer(tapGesture)
        
    }
    
    func setDefaultCurrencySelection()
    {
        pkCurrencyFrom.selectRow(48, inComponent: 0, animated: false)
        pkCurrencyTo.selectRow(41, inComponent: 0, animated: false)
        
        baseCurrency = CurrencyCodes[48]
        targetCurrency = CurrencyCodes[41]
    }
    
    
    @IBAction func btnConvert(_ sender: Any)
    {
        if ((txtAmount.text?.isEmpty) == true)
        {
            let alert = UIAlertController(title: "Error", message: "Please enter amount to convert",preferredStyle: .alert)
        
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let amountToConvert = Double(txtAmount.text ?? "") ?? 0
            
            let convertedAmount = obj.convertCurrency(amount: amountToConvert, fromCurrency: baseCurrency, toCurrency: targetCurrency, viewController: self)
            lblResult?.text = String(convertedAmount ?? 0)
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyCodes.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CurrencyCodes[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == pkCurrencyFrom
        {
            baseCurrency = CurrencyCodes[row]
        }
        else if pickerView == pkCurrencyTo
        {
            targetCurrency = CurrencyCodes[row]
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        btnConvert(self)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
   
    
   
    
}
