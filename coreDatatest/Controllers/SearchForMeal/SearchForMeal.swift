//
//  SearchForMeal.swift
//  coreDatatest
//
//  Created by Ahmed on 03/03/2023.
//

import UIKit
import CoreData


class SearchForMeal: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CellSubclassProductDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var AllProductsCollectionView: UICollectionView!
    @IBOutlet weak var mealsCollectionView: UICollectionView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
     
    //MARK: - Variables
    
    static var ID = String(describing: SearchForMeal.self)
    var hideDeletebtn = true
    var ProductsArray : [Product] = []
    var AllData : [Product] = []
    var mealsArray = ["BreakFast" , "Lunch" , "Dinner" , "Dessert"]
    var itemsArray = ["All" ,"Plates", "Hot drinks" , "Iced coffee"]
    var selectedMeal = ""
    var selectedItem = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
       
        uiSetUp()
    }
      
    
    //MARK: - Functions
    
    
    func uiSetUp(){
        
        AllProductsCollectionView.delegate = self
        AllProductsCollectionView.dataSource = self
        
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
        itemsCollectionView.isHidden = true
        
        
        mealsCollectionView.delegate = self
        mealsCollectionView.dataSource = self
        fetchData()
        AllData = ProductsArray
        AllProductsCollectionView.reloadData()
        setUpcollectioViewCell(for: AllProductsCollectionView, ID: ProductsCollectionViewCell.ID)
        
        
    }
   
    
    // coreData fetch
    
    func fetchData(){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Products")
        do{
            let myProduct = try context.fetch(fetchRequest)
            if myProduct.isEmpty {
                print("nodata")
            }else{
                print(myProduct[0])
                for i in myProduct{
                    ProductsArray.append(Product(image: (i.value(forKey: "image") as? Data), name: (i.value(forKey: "name")) as? String , info: (i.value(forKey: "info") as? String) , meal: (i.value(forKey: "meal") as? String), plate: (i.value(forKey: "plate") as? String), price: (i.value(forKey: "price") as? Double)))
                }
                
            } 
            }catch{
                print(error)
            }
            
    }
    
    // coreData delete
    
    func deleteFromCoreData(indexPath:IndexPath){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Products")
        do{
            let myProduct = try context.fetch(fetchRequest)
            context.delete(myProduct[indexPath.row])
            try context.save()
            }catch{
                print(error)
            }
         
        AllProductsCollectionView.reloadData()
        
    }
    
    
    
    
    func buttonTapped(cell: ProductsCollectionViewCell) {
        guard let indexPath = self.AllProductsCollectionView.indexPath(for: cell) else { return }
            // Delete the cell from the collection view
        AllData.remove(at: indexPath.row)
            // Delete the cell from Core Data
        deleteFromCoreData(indexPath: indexPath)
        self.AllProductsCollectionView.reloadData()
        print("Button tapped on row \(indexPath.row)")
    }
    
    //MARK: - CollectionView SetUp
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case AllProductsCollectionView:
            return AllData.count
        case itemsCollectionView:
            return itemsArray.count
        default:
            return mealsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
            case AllProductsCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.ID, for: indexPath) as! ProductsCollectionViewCell
            let image = UIImage(data: AllData[indexPath.row].image!)
                cell.productImage.image = image
            cell.delegate = self
            cell.deleteProductBtn.isHidden = hideDeletebtn
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.placeholderText.cgColor
            cell.cornerRadius = 10
            cell.productName.text = AllData[indexPath.row].name?.uppercased()
                cell.productPrice.text = "\(AllData[indexPath.row].price!)"
            cell.productMeal.text = AllData[indexPath.row].meal?.uppercased()
            cell.productItem.text = AllData[indexPath.row].plate
                return cell
            
        case itemsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemsCollectionViewCell.ID, for: indexPath) as! itemsCollectionViewCell
            cell.itemsLbl.text = itemsArray[indexPath.row]
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mealCollectionViewCell.ID, for: indexPath) as! mealCollectionViewCell
            cell.mealNameLbl.text = mealsArray[indexPath.row]
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case AllProductsCollectionView:
            return CGSize(width: collectionView.frame.size.width/2.2 + 10, height: 230)
        case itemsCollectionView:
            return CGSize(width: 100, height: 60)
        default:
            return CGSize(width: 140, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case AllProductsCollectionView:
            print("hi")
        case mealsCollectionView:
            UIView.animate(withDuration: 0.7) {
                if self.itemsCollectionView.isHidden {
                    self.itemsCollectionView.alpha = 0.1
                    self.itemsCollectionView.isHidden = false
                    self.itemsCollectionView.alpha = 1
                }
            }
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(named: "red")
         
            selectedMeal = mealsArray[indexPath.row]
            
            if selectedItem == "All"{
                selectedItem = ""
            }
                AllData = ProductsArray.filter({$0.plate!.hasSuffix(selectedItem)})
                AllData = AllData.filter({$0.meal!.hasPrefix(selectedMeal)})
        default:
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(named: "red")
             
            if itemsArray[indexPath.row] == "All"{
                AllData = ProductsArray.filter({$0.meal!.hasPrefix(selectedMeal)})
                selectedItem = "All"
                
            }else{
                selectedItem = itemsArray[indexPath.row]
                AllData = ProductsArray.filter({$0.meal!.hasPrefix(selectedMeal)})
                AllData = AllData.filter({$0.plate!.hasSuffix(selectedItem)})
            }
        }
        AllProductsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView{
        case AllProductsCollectionView:
            print("hello")
        case mealsCollectionView:
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .white
        default:
            collectionView.cellForItem(at: indexPath )?.backgroundColor = .clear
        }
    }
     
    
    //nib file
    
    func setUpcollectioViewCell (for collectionView : UICollectionView , ID : String ){
        let nib = UINib(nibName: ID , bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ID )
        
    }
    
    
    //MARK: - IBActions
    
    @IBAction func showDeleteBtn(_ sender: UIButton) {
        
        if hideDeletebtn == true{
            hideDeletebtn = false
            AllProductsCollectionView.reloadData()
            sender.setTitle("Cancel", for: .normal)
        }else{
            hideDeletebtn = true
            AllProductsCollectionView.reloadData()
            sender.setTitle("Delete Product", for: .normal)
        }
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
 
