import Foundation



public class clsUtility
{
    public static func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
}
