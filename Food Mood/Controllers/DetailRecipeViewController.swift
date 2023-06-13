//
//  DetailRecipeViewController.swift
//  Food Mood
//
//  Created by Nikita Kuznetsov on 10.04.2023.
//

import UIKit
import Alamofire
import RealmSwift

class DetailRecipeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var ingrLabel: UILabel!
    @IBOutlet weak var DishImage: UIImageView!
    @IBOutlet weak var bookMarkButton: UIBarButtonItem!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let recipe = recipe {
            titleLabel.text = recipe.label
                yieldLabel.text = "For \(recipe.yield) person(s)"
//            ingrLabel.text = recipe.ingredientLines.joined(separator: "\n")
            let imageUrl = recipe.image 
            AF.request(imageUrl).response { response in
                if let imageData = response.data {
                    let image = UIImage(data: imageData)
                    self.DishImage.image = image
                }
            }
            
            }
        }
    @IBAction func bookMarkButtonAction(_ sender: Any) {
        showAlert()
        StorageManager.shared.save(recipes: recipe!)
    }
    
    private func showAlert() {
        let alert = AlertController(title: "Important", message: "Save your bookmark?", preferredStyle: .alert)
        alert.actionWIthTaskList()
        present(alert, animated: true)
    }
}

 
