import SQLite

class clsExchangeRatesSqLite
{
    static var db: Connection!
    static let table = Table("exchangeRates")
    static let id = Expression<Int64>("id")
    static let currency = Expression<String>("currency")
    static let currencyRate = Expression<Double>("rate")
    static let isFavorite = Expression<Bool>("isFavorite")

    
    static func setupDatabase()
    {
        do
        {
            let dbPath = DatabaseConfig.dbPath
            db = try Connection(dbPath)
            createTable()
        }
        catch
        {
            print("Error setting up SQLite database: \(error)")
        }
    }
    
    static func createTable()
    {
        do
        {
            try db.run(table.create(ifNotExists: true)
                       { t in
                t.column(id, primaryKey: true)
                t.column(currency)
                t.column(currencyRate)
                t.column(isFavorite)
            })
        }
        catch
        {
            print("Error creating table: \(error)")
        }
    }
    
    static func insertRates(rates: [clsExchangeRate])
    {
        do {
            for rate in rates
            {
                let insert = table.insert(
                    currency <- rate.Currency ?? "",
                    currencyRate <- rate.Rate ?? 0.0,
                    isFavorite <- false

                )
                try db.run(insert)
            }
        }
        catch
        {
            print("Error inserting exchange rates: \(error)")
        }
    }
    
    static func fetchRates() -> [clsExchangeRate]
    {
        var rates = [clsExchangeRate]()
        
        do
        {
            for row in try db.prepare(table)
            {
                let rate = clsExchangeRate(currency: row[currency], rate: row[currencyRate],IsFavorite: row[isFavorite])
                
                rates.append(rate)
                
            }
            
            rates =  rates.sorted { $0.Currency ?? "" < $1.Currency ?? "" }

        }
        catch
        {
            print("Error fetching exchange rates from SQLite: \(error)")
            
        }
        
        return rates
    }
    

    static func setFavorite(currencyCode: String, isFavorite: Bool) -> Bool
    {
        do {
            let currencyRow = table.filter(currency == currencyCode)
            let update = currencyRow.update(self.isFavorite <- isFavorite)
            try db.run(update)
            return true
        }
        catch
        {
            print("Error setting favorite status: \(error)")
            return false
        }
    }
    
  
    static func isCurrencyFavorite(currencyCode: String) -> Bool {
        do {

            let currencyRow = table.filter(currency == currencyCode)
            

            if let row = try db.pluck(currencyRow) {

                return row[isFavorite]
            } else {

                return false
            }
        } catch {
            print("Error checking if currency is favorite: \(error)")
            return false
        }
    }


}
