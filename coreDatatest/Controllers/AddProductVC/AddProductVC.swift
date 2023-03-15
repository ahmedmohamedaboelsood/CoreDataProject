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
    var AddProductImageArray : [ProductImage] = [ProductImage(type:"add", image: nil)]
    var product : Product?
    var mealCounter = -1
    var itemCounter = -1
    var priceCounter = 0.0
    var meals = ["BreakFast" , "Lunch" , "Dinner" , "Dessert"]
    var items = ["Plates", "Hot drinks" , "Iced coffee"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        uiSetup()
        
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
    
    //MARK: - ImagePiker
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
    
    func uiSetup(){
        
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        priceTxtfeild.delegate = self
        addImageCollectionView.delegate = self
        addImageCollectionView.dataSource = self
        setupCollectioViewCell(for: addImageCollectionView , ID: imageCollectionViewcell.ID)
        
    }
    
    
    func addProductToCoreData(product : Product){
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Products", into: context) as! Products
        entity.image = product.image
        entity.plate = product.plate
        entity.meal = product.meal
        entity.info = product.info
        entity.name = product.name
        entity.price = product.price!
        
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
            if priceTxtfeild.text == ""{
                priceTxtfeild.text = "0.0"
                priceTxtfeild.text =  String(Double(priceTxtfeild.text!)!+1)
            }else{
                priceTxtfeild.text =  String(Double(priceTxtfeild.text!)!+1)
            }
        default:
            
            if priceTxtfeild.text == ""{
                
                priceTxtfeild.text = "0.0"
            }else{
                if Double(priceTxtfeild.text!)! <= 0{
                    priceTxtfeild.text = "\(0.0)"
                }else{
                    priceTxtfeild.text = String(Double(priceTxtfeild.text!)!-1)
                }
            }
            
        }
    }
    
    
    
    @IBAction func savedataBtn(_ sender: Any) {
        if AddProductImageArray.count != 1 {
            let jpegImageData = AddProductImageArray[0].image!.jpegData(compressionQuality: 1.0)
            
            if !jpegImageData!.isEmpty{
                
                guard let name = productNameTxtField.text  , !name.trimmingCharacters(in: .whitespaces).isEmpty else {
                    showAlert(massege: "Enter Product Name")
                    return
                }
                
                guard let Info = productInfoTxtFeild.text  , !Info.trimmingCharacters(in: .whitespaces).isEmpty else {
                    showAlert(massege: "Enter Product Info")
                    return
                }
                
                guard let meal = mealsTxtField.text  , !meal.trimmingCharacters(in: .whitespaces).isEmpty else {
                    showAlert(massege: "Enter Product Meal")
                    return
                }
                
                
                guard let item = itemTxtfield.text  , !item.trimmingCharacters(in: .whitespaces).isEmpty else {
                    showAlert(massege: "Enter Product Item")
                    return
                }
                
                guard let price = priceTxtfeild.text  , !price.trimmingCharacters(in: .whitespaces).isEmpty else {
                    showAlert(massege: "Enter Product Price")
                    return
                }
                
                    product =  Product(image:  jpegImageData!  , name: name, info: Info, meal: meal, plate: item, price: Double(price))
                
                    addProductToCoreData(product: self.product!)
                    do{
                        try context.save()
                        print("added")
                        showAlert(massege: "Product Added Successfully")
                    }catch{
                        print(error)
                    }
            }
            
        }else{
            showAlert(massege: "Please Enter Photo")
        }
        
    }
    
    @IBAction func backHome(_ sender: UIButton) { 
        self.dismiss(animated: true)
    }
    
}

 

extension AddProductVC : UITextFieldDelegate{
     
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
    
}
