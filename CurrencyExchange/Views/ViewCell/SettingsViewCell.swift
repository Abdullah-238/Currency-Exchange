//
//  SettingsViewCell.swift
//  CurrencyExchange
//
//  Created by Abdullah on 15/10/1446 AH.
//

import UIKit

class SettingsViewCell: UITableViewCell {

    
    @IBOutlet weak var imgSetting: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }
    
    public func SetCell(Title : String! , Description : String! , Image : UIImage!)
    {
        imgSetting.image =  Image
        lblDesc.text = Description
        lblTitle.text = Title
        
        imgSetting.tintColor = UIColor(resource: ColorResource.primary)
    }

}
