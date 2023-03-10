//
//  imageCollectionViewcell.swift
//  coreDatatest
//
//  Created by Ahmed on 02/03/2023.
//

import UIKit

protocol CellSubclassDelegate {
    func buttonTapped(cell: imageCollectionViewcell)
}


class imageCollectionViewcell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var deleteImage: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    
    static var ID = String(describing: imageCollectionViewcell.self)
    var delegate: CellSubclassDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.delegate = nil
    }
    
    
    @IBAction func deleteImgeBtn(_ sender: Any) {
        self.delegate?.buttonTapped(cell: self) 
    }
    

}
