import Foundation



public class DatabaseConfig
{
    static var dbPath: String {
        
        let path = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("exchangeRates.sqlite3").path
        return path
    }
}
