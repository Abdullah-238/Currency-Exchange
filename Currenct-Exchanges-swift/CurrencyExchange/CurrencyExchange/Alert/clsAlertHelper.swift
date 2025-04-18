

import UIKit


class clsAlertHelper
{
    
    static func showConversionRateError(from viewController: UIViewController) {
        let alert = UIAlertController(title: "Error", message: "Conversion rates not available", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

