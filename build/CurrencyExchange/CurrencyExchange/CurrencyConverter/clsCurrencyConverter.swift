import Foundation
import UIKit



public class clsCurrencyConverter {
    
    
    struct ExchangeRateResponse: Decodable
    {
        let conversion_rates: [String: Double]
    }

    var objResponse: ExchangeRateResponse?
    
    
    public init()
    {
        fetchExchangeRates { response in
            self.objResponse = response
        }
    }
    
    func fetchExchangeRates(completion: @escaping (ExchangeRateResponse?) -> Void)
    {
        let url = URL(string: "https://v6.exchangerate-api.com/v6/19ed1657e22a016bda03d9a3/latest/USD")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching exchange rates: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do
            {
                let decodedResponse = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                self.objResponse = decodedResponse
                completion(decodedResponse)
            } catch
            {
                print("Error decoding exchange rates: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func convertCurrency(amount: Double, fromCurrency: String, toCurrency: String, viewController: UIViewController) -> Double?
    {
        guard let rates = objResponse?.conversion_rates
        else
        {
            clsAlertHelper.showConversionRateError(from: viewController)
            return nil
        }
        
        if let fromRate = rates[fromCurrency], let toRate = rates[toCurrency]
        {
            let conversionRate = toRate / fromRate
            let convertedAmount = amount * conversionRate
            return convertedAmount
        }
        else
        {
            clsAlertHelper.showConversionRateError(from: viewController)
            return nil
        }
    }
}
