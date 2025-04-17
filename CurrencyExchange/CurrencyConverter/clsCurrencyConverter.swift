import Foundation
import UIKit



public class clsCurrencyConverter
{
    
    struct ExchangeRates: Decodable
    {
        var conversion_rates: [String: Double]
    }

    
    var objResponse: [clsExchangeRate]!
    
    public init()
    {
        Load()
    }
    
    
    func Load()
    {
        let currentDate = Date()
        clsExchangeRatesSqLite.setupDatabase()
        let storedRates = clsExchangeRatesSqLite.fetchRates()
        
        let lastFetchedDate = UserDefaults.standard.object(forKey: clsConstant.lastFetchedDate) as? Date
        let shouldFetchFromAPI = lastFetchedDate == nil ||
                                 currentDate.timeIntervalSince(lastFetchedDate!) > 6 * 60 * 60 ||
                                 storedRates.isEmpty
        
        if shouldFetchFromAPI
        {
            fetchExchangeRates { response in self.objResponse = response
                
                if let rates = response, !rates.isEmpty
                {
                    clsExchangeRatesSqLite.insertRates(rates: rates)
                    UserDefaults.standard.set(currentDate, forKey: clsConstant.lastFetchedDate)
                }
            }
        }
        else
        {
            objResponse = storedRates
        }
    }

    
    

   
    func fetchExchangeRates(completion: @escaping ([clsExchangeRate]?) -> Void)
    {
           guard let url = URL(string: clsConstant.UrlExchangeRate)
        else
        {
               print("Invalid URL")
               completion(nil)
               return
           }
           
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
               
               do {
                   let decodedResponse = try JSONDecoder().decode(ExchangeRates.self, from: data)
                   
                   let exchangeRates = self.convertToExchangeRateList(conversion_rates: decodedResponse.conversion_rates)
                   
                   completion(exchangeRates)
                   
                   self.objResponse = exchangeRates
                   
                   DispatchQueue.main.async {
                       UserDefaults.standard.set(Date(), forKey: clsConstant.lastFetchedDate)
                   }
                   
               } catch {
                   print("Error decoding exchange rates: \(error)")
                   completion(nil)
               }
           }
           
           task.resume()
       }
       
    
    
    func convertToExchangeRateList(conversion_rates: [String: Double]) -> [clsExchangeRate]
    {
        var exchangeRates: [clsExchangeRate] = []
        
        for (currency, rate) in conversion_rates
        {
            let exchangeRate = clsExchangeRate(currency: currency, rate: rate)
            exchangeRates.append(exchangeRate)
        }
        
        return exchangeRates
    }

    func convertCurrency(amount: Double, fromCurrency: String, toCurrency: String, viewController: UIViewController) -> Double?
    {
        guard let rates = objResponse else
        {
            clsAlertHelper.showConversionRateError(from: viewController, Title: "Error", Message: "Conversion rates not available")
            return nil
        }
        
        if let fromRateObject = rates.first(where: { $0.Currency == fromCurrency }),
           let toRateObject = rates.first(where: { $0.Currency == toCurrency }) {
            
            let fromRate = fromRateObject.Rate ?? 0.0
            let toRate = toRateObject.Rate ?? 0.0
            
            if fromRate == 0.0 || toRate == 0.0
            {
                clsAlertHelper.showConversionRateError(from: viewController, Title: "Error", Message: "Invalid conversion rate found.")
                return nil
            }
            
            let conversionRate = toRate / fromRate
            let convertedAmount = amount * conversionRate
            return convertedAmount
        }
        else
        {
            clsAlertHelper.showConversionRateError(from: viewController, Title: "Error", Message: "Conversion rates not available for the selected currencies")
            return nil
        }
    }
    

}
