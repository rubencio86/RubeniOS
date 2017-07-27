import UIKit

class SimpleViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var recipe = Recipe(name: "Tacos",
                            image: #imageLiteral(resourceName: "pizza"),
                            time: 20,
                            ingredient: ["Tortilla", "Carne", "Ahogao"],
                            step: ["Preparar la Tortilla", "Poner la carne",])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Goulash",
                        image: #imageLiteral(resourceName: "Goulassh"),
                        time: 30,
                        ingredient: ["Carne", "Salsa Negra", "Verduras"],
                        step: ["Preparar las Verduras", "Revolver con la Carne",])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Pollo",
                        image: #imageLiteral(resourceName: "Pollo"),
                        time: 40,
                        ingredient: ["Pollo", "Cocacola", "Pimienta"],
                        step: ["Se cocina el Pollo", "Se prepara la Salsa",])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Sopa",
                        image: #imageLiteral(resourceName: "Sopa"),
                        time: 10,
                        ingredient: ["Agua", "Pastas", "Verduras"],
                        step: ["Se cocinan las verduras", "Se revuelven con los demas ingredientes",])
        recipes.append(recipe)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

extension SimpleViewController : UITableViewDataSource {
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipes[indexPath.row]
        let cellId = "RecipeCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FullRecipeCell1
        cell.imageRecipe.image = recipe.imagen
        /*cell.recipeImage.layer.cornerRadius = 42.0
         cell.recipeImage.clipsToBounds = true*/
        
        cell.nameRecipe.text = recipe.nombre
        /*cell.timeRecipe.text = "\(recipe.time!) min"
         cell.ingredientsRecipe.text = "ingredients: \(recipe.ingredient.count)"*/
        
        //cell.textLabel?.text = recipe.name
        //cell.imageView?.image = recipe.image
        return cell
    }
    
}

