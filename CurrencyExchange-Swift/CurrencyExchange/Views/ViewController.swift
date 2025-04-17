
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
    
    var obj : [clsExchangeRate]!
    
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
        
        obj = clsGlobal.currencyConverter.objResponse
        
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
            clsAlertHelper.showConversionRateError(from: self, Title: NSLocalizedString("Error", comment: "Error"), Message: NSLocalizedString("Please enter amount to convert", comment: ""))
            

        }
        else
        {
            let amountToConvert = Double(txtAmount.text ?? "") ?? 0
            
            let convertedAmount = clsGlobal.currencyConverter.convertCurrency(amount: amountToConvert, fromCurrency: baseCurrency, toCurrency: targetCurrency, viewController: self) ?? 0

           
                lblResult?.text = formatNumber(convertedAmount)
        }
    }
    
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return CurrencyCodes.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
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
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        btnConvert(self)
        textField.resignFirstResponder()
        return true
    }
    
    func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
}
