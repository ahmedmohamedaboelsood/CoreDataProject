//
//  CollectionViewCell.swift
//  coreDatatest
//
//  Created by Ahmed on 03/03/2023.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    static var ID = String(describing: ProductsCollectionViewCell.self)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
