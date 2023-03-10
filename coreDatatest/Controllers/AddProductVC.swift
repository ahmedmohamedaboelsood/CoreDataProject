//
//  AddProductVC.swift
//  coreDatatest
//
//  Created by Ahmed on 02/03/2023.
//

import UIKit
import PhotosUI
import CoreData


class AddProductVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,CellSubclassDelegate ,PHPickerViewControllerDelegate, UIImagePickerControllerDelegate{
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var priceTxtfeild: UITextField!
    @IBOutlet weak var mealsTxtField: UITextField!
    @IBOutlet weak var itemTxtfield: UITextField!
    @IBOutlet weak var productInfoTxtFeild: UITextField!
    @IBOutlet weak var productNameTxtField: UITextField!
    
    @IBOutlet weak var addImageCollectionView: UICollectionView!
  
    //MARK: - Variables
    
    
    static var ID = String(describing: AddProductVC.self)
     
    var AddProductImageArray : [ProductImage] = [ProductImage(type:
"add", image: nil)]
    
    var ProductArray : [Product] = []
    
    var mealCounter = -1
    var itemCounter = -1
    var priceCounter = 0.0
    
    var meals = ["BreakFast" , "Lunch" , "Dinner" , "Dessert"]
    var items = ["Plates", "Hot drinks" , "Iced coffee"]
    static let entity = NSEntityDescription.entity(forEntityName: "Products", in: context)
    let product = NSManagedObject(entity: entity!, insertInto: context) 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        addImageCollectionView.delegate = self
        addImageCollectionView.dataSource = self
        setupCollectioViewCell(for: addImageCollectionView , ID: imageCollectionViewcell.ID)
        priceTxtfeild.text = "0.0"
    }
     
    
    //MARK: - UICollectionView Setup
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AddProductImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCollectionViewcell.ID, for: indexPath) as! imageCollectionViewcell
        cell.delegate = self
        
        if AddProductImageArray[indexPath.row].type == "add"{
            cell.productImage.image = UIImage(named: AddProductImageArray[indexPath.row].type!)
            cell.deleteImage.isHidden = true
            print(AddProductImageArray[indexPath.row].type!)
        }else{
            cell.productImage.image = AddProductImageArray[indexPath.row].image
            cell.deleteImage.isHidden = false
            print(AddProductImageArray[indexPath.row].type!)
              
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        checkCell(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90 , height: 90)
    }

    
    
    func setupCollectioViewCell(for collectionView:UICollectionView , ID :String){
        let nib = UINib(nibName: ID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ID)
    }
    
    
    
    func checkCell (_ indexPath: IndexPath){
        if AddProductImageArray[indexPath.row].type! == "add"{
            pickImage()
            self.addImageCollectionView.reloadData()
        }
    }
    
    
    
    
    // Delete Image Button
    func buttonTapped(cell: imageCollectionViewcell) {
        guard let indexPath = self.addImageCollectionView.indexPath(for: cell) else { return }
        
        AddProductImageArray.remove(at: indexPath.row)
        self.addImageCollectionView.reloadData()
        print("Button tapped on row \(indexPath.row)")
    }
    
    //Image Picker
    func pickImage(){
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        if results.isEmpty{
            print("canceled")
 
        }
        
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                
                if let image = object as? UIImage{
                   
                    self.AddProductImageArray.insert(ProductImage(type: "", image: image), at: 0)
                    DispatchQueue.main.async {
                        self.addImageCollectionView.reloadData()
                    }
                   
                }
                
                print(error?.localizedDescription as Any)
            })
        }
    }
    //MARK: - Functions
    
    // Alert Action
    
    func showAlert(title : String) {
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - IBActions
    
    @IBAction func mealSwitchUp(_ sender: UIButton) {
        
        switch sender.tag{
        case 0 :
 
            (mealCounter < meals.count-1) ? (mealCounter += 1) : (mealCounter = 0)
            mealsTxtField.text = meals[mealCounter]
        default :
 
            if mealCounter < 0 {
                mealCounter = 0
            }
            (mealCounter > 0) ? (mealCounter -= 1 ) : (mealCounter = meals.count - 1)
            mealsTxtField.text = meals[mealCounter]
            
        }
    }
    
    
    
    
    @IBAction func itemButtonUp(_ sender: UIButton) {
        switch sender.tag{
        case 2 :
            (itemCounter < items.count-1) ? (itemCounter += 1) : (itemCounter = 0)
            itemTxtfield.text = items[itemCounter]
        default :
            if itemCounter < 0 {
                itemCounter = 0
            }
            (itemCounter > 0) ? (itemCounter -= 1 ) : (itemCounter = items.count - 1)
            itemTxtfield.text = items[itemCounter]
        }
    }
    
    
    @IBAction func priceBtns(_ sender: UIButton) {
        switch sender.tag {
        case 4:
            priceCounter += 1.0
            priceTxtfeild.text = "\(priceCounter)"
        default:
            
            priceCounter -= 1.0
            if priceCounter < 0{
                priceCounter = 0.0
                priceTxtfeild.text = "\(0.0)"
                
            }else{
                priceCounter -= 1.0
                priceTxtfeild.text = "\(priceCounter)"
            }
            
        }
    }
    
    
    @IBAction func savedataBtn(_ sender: Any) {
        if AddProductImageArray.count != 1 {
            let jpegImageData = AddProductImageArray[0].image!.jpegData(compressionQuality: 1.0)
            
            if !jpegImageData!.isEmpty{
                
                if productNameTxtField.text!.isEmpty || productInfoTxtFeild.text!.isEmpty || mealsTxtField.text!.isEmpty || itemTxtfield.text!.isEmpty||priceTxtfeild.text!.isEmpty{
                    showAlert(title: "Please Enter All Data")
                    //print("Enter data")
                }else{
                    ProductArray = [Product(image:  jpegImageData!  , name: productNameTxtField.text, info: productInfoTxtFeild.text, meal: mealsTxtField.text, plate: itemTxtfield.text, price: Double(priceTxtfeild.text!))]
                    
                    print((ProductArray.first?.image)!)
                    for i in 0...ProductArray.count-1{
                        product.setValue(ProductArray[i].image , forKey: "image")
                        product.setValue(ProductArray[i].name , forKey: "name")
                        product.setValue(ProductArray[i].plate , forKey: "plate")
                        product.setValue(ProductArray[i].price , forKey: "price")
                        product.setValue(ProductArray[i].info , forKey: "info")
                        product.setValue(ProductArray[i].meal , forKey: "meal")
                        do{
                            try context.save()
                            print("added")
                             showAlert(title: "Product Added Successfully")
                        }catch{
                            print(error)
                        }
                    }
                    
                }
            }else{
                showAlert(title: "Please Enter Data")
                 
            }
            
            
       
        }else{
            showAlert(title: "Please Enter Photo")
            //print("enter Photo")
        }
    }
    
    @IBAction func backHome(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    
    
}
    
    
    
    
   
