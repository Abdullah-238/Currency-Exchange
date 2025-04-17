import UIKit


class clsAlertHelper
{
    static func showConversionRateError(from viewController: UIViewController, Title : String , Message : String)
    {
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Done", comment: "Done"), style: .default, handler: nil))

        viewController.present(alert, animated: true, completion: nil)
       
    }
}

