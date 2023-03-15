//
//  CollectionViewCell.swift
//  coreDatatest
//
//  Created by Ahmed on 03/03/2023.
//

import UIKit
import CoreData

protocol CellSubclassProductDelegate {
    func buttonTapped(cell: ProductsCollectionViewCell)
}

class ProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var deleteProductBtn: UIButton!
    @IBOutlet weak var productItem: UILabel!
    @IBOutlet weak var productMeal: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    static var ID = String(describing: ProductsCollectionViewCell.self)
    
    var delegate: CellSubclassProductDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate.self = nil
    }

    @IBAction func deleteProduct(_ sender: UIButton) {
        
        self.delegate?.buttonTapped(cell: self)
        
//        let indexToDelete = IndexPath(row: sender.tag, section: 0)
//           // Delete the cell from Core Data
//           let objectToDelete = fetchedResultsController.object(at: indexToDelete)
//           context.delete(objectToDelete)
//           try? context.save()
//
//           // Delete the cell from the collection view
//           collectionView.deleteItems(at: [indexToDelete])
    }
}
