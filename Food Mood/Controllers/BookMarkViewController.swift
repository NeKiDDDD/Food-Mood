//
//  Breakfast.swift
//  Food Mood
//
//  Created by Nikita Kuznetsov on 13.03.2023.
//

import UIKit
import RealmSwift
import Alamofire

class BookMarkViewController: UIViewController {

    @IBOutlet weak var bookMarkTableView: UITableView!
    
    let cellID = "bookMarkCell"
    var resultRecipes = [Recipe]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableInit()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookMarkTableView.reloadData()
    }
    
    private func tableInit(){
        bookMarkTableView.dataSource = self
        bookMarkTableView.delegate = self
        bookMarkTableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
}

extension BookMarkViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let recipes = realm.objects(Recipe.self)
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookMarkTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! bookMarkCell
        let realm = try! Realm()
        let recipes = realm.objects(Recipe.self)
        cell.nameMark.text = recipes[indexPath.row].label
        let imageUrl = recipes[indexPath.row].image
        AF.request(imageUrl).response { response in
            if let imageData = response.data {
                let image = UIImage(data: imageData)
                cell.imageMark.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailRecipeViewController") as! DetailRecipeViewController
        let realm = try! Realm()
        let recipes = realm.objects(Recipe.self)
        let selectedRecipe = recipes[indexPath.row]
        detailVC.recipe = selectedRecipe
        navigationController?.pushViewController(detailVC, animated: true)
        print("Selected row at index: \(indexPath.row)")
    }
}

