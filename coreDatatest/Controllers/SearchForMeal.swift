//
//  SearchForMeal.swift
//  coreDatatest
//
//  Created by Ahmed on 03/03/2023.
//

import UIKit
import CoreData


class SearchForMeal: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
     
    
    @IBOutlet weak var AllProductsCollectionView: UICollectionView!
    @IBOutlet weak var mealsCollectionView: UICollectionView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
     
    
    static var ID = String(describing: SearchForMeal.self)
     
    var ProductsArray : [Product] = []
    var mealsArray = ["BreakFast" , "Lunch" , "Dinner" , "Dessert"]
    var itemsArray = ["All" ,"Plates", "Hot drinks" , "Iced coffee"]
    var selectedMeal = ""
    var selectedItem = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        AllProductsCollectionView.delegate = self
        AllProductsCollectionView.dataSource = self
        
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self

        mealsCollectionView.delegate = self
        mealsCollectionView.dataSource = self
        fetchData() 
        setUpcollectioViewCell(for: AllProductsCollectionView, ID: ProductsCollectionViewCell.ID)
    }
      
   
    
    func fetchData(){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Products")
        do{
            let myProduct = try context.fetch(fetchRequest)
            
            if myProduct.isEmpty {
                
                print("nodata")
                
            }else{
                
                print(myProduct[0])
                
                for i in myProduct{
                    ProductsArray.append(Product(image: (i.value(forKey: "image") as! Data), name: (i.value(forKey: "name")) as? String , info: (i.value(forKey: "info") as! String) , meal: (i.value(forKey: "meal") as! String), plate: (i.value(forKey: "plate") as! String), price: (i.value(forKey: "price") as? Double)))
                }
                
                AllProductsCollectionView.reloadData()
                
            } 
            }catch{
                print(error)
            }
            
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case AllProductsCollectionView:
            return ProductsArray.count
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
                let image = UIImage(data: ProductsArray[indexPath.row].image!)
                cell.productImage.image = image
                cell.productName.text = ProductsArray[indexPath.row].name
                cell.productPrice.text = "\(ProductsArray[indexPath.row].price!)"
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
            return CGSize(width: collectionView.frame.size.width/2.2 + 10, height: collectionView.frame.size.height/2)
        case itemsCollectionView:
            return CGSize(width: 100, height: 60)
        default:
            return CGSize(width: 140, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case AllProductsCollectionView:
            print("hello")
        case mealsCollectionView:
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(named: "red")
            selectedMeal = mealsArray[indexPath.row]
            ProductsArray = ProductsArray.filter {
                $0.meal == selectedMeal
            }
            AllProductsCollectionView.reloadData()
            print(selectedMeal)
        default:
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(named: "red")
            if selectedItem == "All"{
                fetchData()
            }else{
                ProductsArray = ProductsArray.filter{
                    $0.plate == selectedItem
                }
            } 
            AllProductsCollectionView.reloadData()
            selectedItem = itemsArray[indexPath.row]
            print(selectedItem)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView{
        case AllProductsCollectionView:
            print("hello")
        case mealsCollectionView:
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .white
            ProductsArray = []
            fetchData()
        default:
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .clear
            ProductsArray = []
            fetchData()
        }
    }
    
    
    
    func setUpcollectioViewCell (for collectionView : UICollectionView , ID : String ){
        
        let nib = UINib(nibName: ID , bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ID )
        
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    

    
   
}
 
