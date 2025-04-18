

public class clsExchangeRate: Decodable
{

    public var Currency: String?
    
    public var Rate: Double!

    public var IsFavorite : Bool?
    
    public init(currency : String?, rate :Double, IsFavorite : Bool? = nil)
    {
        self.Currency = currency
        self.Rate = rate
        self.IsFavorite = IsFavorite
    }
    
    public init()
    {
        self.Currency = nil
        self.Rate = nil
        self.IsFavorite = nil
    }

}
