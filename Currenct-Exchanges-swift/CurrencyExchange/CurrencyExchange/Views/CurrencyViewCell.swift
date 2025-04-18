//
//  CurrencyViewCell.swift
//  CurrencyExchange
//
//  Created by Abdullah on 04/10/1446 AH.
//

import UIKit

class CurrencyViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    
    public func SetCell(Title : String , Description : String , Price : Double)
    {
        lblPrice.text = "\(Price)"
        lblDesc.text = Description
        lblTitle.text = Title
    }

}
