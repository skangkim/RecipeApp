//
//  ViewController.swift
//  food
//
//  Created by J Lee on 7/24/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit
import CoreData
class SearchViewController: UIViewController {
    
    var index: Int?
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var steps: UILabel!
    
    @IBOutlet weak var filledHeart: UIImageView!
    @IBAction func heartTapped(_ sender: Any) {
        //delete from favorites
        
        let context = AppDelegate.persistentContainer.viewContext
        if(MyRecipeArr[index!].value(forKey: "isFav") as! Bool){
            // if it's favorite, delete from fav
            let image = UIImage(named: "")
            filledHeart.image = image
            MyRecipeArr[index!].setValue(false, forKey: "isFav")
        }
        else{
            let image = UIImage(named: "icons8-heart-30.png")
            filledHeart.image = image
            MyRecipeArr[index!].setValue(true, forKey: "isFav")
        }
        
        
        // context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        // save changes
        do{ try context.save() }
        catch let error as NSError{ print("couldnt delete @ searchviewcontroller. Error: \(error)") }
        
    }
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var numIngredientsNeeded: UILabel!
    
    
    @IBAction func addShoppingListTapped(_ sender: UIButton) {
        // MARK: TODO: need to implement shopping list tapped
        // MARK: just for now, add all
        
        let context = AppDelegate.persistentContainer.viewContext
        let r = MyRecipeArr[index!]
        
        do{
            let fetchIngred = NSFetchRequest<IngredInfo>(entityName: "IngredInfo")
            fetchIngred.predicate = NSPredicate(format: "recipe == %@", r)
            let ingreds = try context.fetch(fetchIngred)
            for i in ingreds{
                i.setValue(true, forKey: "isSL")
            }
            
        }
        catch let error as NSError{
            print("addSL failed: \(error)")
        }
        // save changes

        do{ try context.save() }
        catch { print("failed saving addSL") }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationItem.title = RecipeBook[index!].FoodName;
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor("8cd600")
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        //        //get rid of bottom line of navigation
        //        let navigationBar = navigationController!.navigationBar
        //        navigationBar.isTranslucent = false
        //        navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        navigationBar.shadowImage = UIImage()
        
        //setting the page info
        
        let recipe = MyRecipeArr[index!]
        recipeName.text = recipe.value(forKey: "name") as! String
        steps.text = recipe.value(forKey: "steps") as! String
        
        
        numIngredientsNeeded.text = ""
        addButton.isHidden = true
        
        if(recipe.value(forKey: "isFav") as! Bool){
            let image = UIImage(named: "icons8-heart-30.png")
            filledHeart.image = image
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
