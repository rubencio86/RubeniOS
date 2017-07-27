//
//  DetailViewController.swift
//  Recetas
//
//  Created by Rubencio Casado on 03/05/17.
//

import UIKit
import Photos

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    //Botón para salvar la imagen.
    @IBAction func salvaImagen(_ sender: Any) {
        
        if libreriaFotosPermisos {
            if let imagen = imageView.image {
                UIImageWriteToSavedPhotosAlbum(imagen, self, #selector(self.imagen(image:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                alertText(text: "Primero toma una fotográfia")
            }
        } else {
            
            alertText(text: "No tiene permisos para acceder al carrete")
        }
        
        
    }
    
    func imagen(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        
        if error == nil {
            alertText(text: "Guardado con éxito")
        } else {
            alertText(text: "La imagen no se ha podido guardar correctamente")
        }
        
    }
    
    @IBOutlet var imageRecipeDetail: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var ratingButton: UIButton!
    
    var recipe : Recipe!
    
    var camaraPermisos : Bool = false
    var libreriaFotosPermisos : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Camara, gesto.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCameraUI))
        imageView.addGestureRecognizer(tapGesture)
        
        
        
        self.title = recipe.nombre
        self.imageRecipeDetail.image = self.recipe.imagen
        self.tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let image = UIImage(named: self.recipe.rating)
        self.ratingButton.setImage(image, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Invocamos el metodo de los permisos de la cámara
        permisosCamara()
    }
    
    //Permisos para la cámara.
    
    func permisosCamara() {
        //Comprobar si hay o no permisos.
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (granted) in
            self.camaraPermisos = granted
            
        }
        
        PHPhotoLibrary.requestAuthorization { (estado) in
            switch estado {
            case .authorized:
                self.libreriaFotosPermisos = true
            default:
                self.libreriaFotosPermisos = false
            }
        }
        
        
    }
    
    //Abrir camara
    func openCameraUI() {
        
        if camaraPermisos {
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                let camaraVC = UIImagePickerController()
                camaraVC.delegate = self
                camaraVC.allowsEditing = false
                camaraVC.sourceType = .camera
                camaraVC.cameraCaptureMode = .photo
                
                self.present(camaraVC, animated: true, completion: nil)
                
                
            } else {
                alertText(text: "La cámara no está disponible en éste momento")
            }
            
            
        } else {
            
            alertText(text: "No tienes permisos para utulizar la camara")
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imagen = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = imagen
            
        } else {
            alertText(text: "Error al cargar la imagen del Picker")
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    //Mensajes de alerta de cámara
    func alertText(text: String) {
        let alertVC = UIAlertController(title: "Mensaje", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        
        if let reviewVC = segue.source as? ReviewViewController {
            
            if let rating = reviewVC.ratingSelected {
                self.recipe.rating = rating
                let image = UIImage(named: self.recipe.rating)
                self.ratingButton.setImage(image, for: .normal)
            }
        }
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



extension DetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return self.recipe.ingredientes.count
        case 2:
            return self.recipe.pasos.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRecipeCell", for: indexPath) as! RecipeDetailViewCellTableViewCell
        
        cell.backgroundColor = UIColor.clear
        
        //Configuración de las diferentes celdas según las secciones
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.keyNameRecipeDetail.text = "Nombre :"
                cell.nameRecipeDetail.text = self.recipe.nombre
            case 1:
                cell.keyNameRecipeDetail.text = "Tiempo de Receta :"
                cell.nameRecipeDetail.text = "\(self.recipe.tiempo!) Min"
                /*case 2:
                 cell.keyNameRecipeDetail.text = "Favourite :"
                 if self.recipe.isFavourite {
                 cell.nameRecipeDetail.text = "Si"
                 } else {
                 cell.nameRecipeDetail.text = "No"
                 }*/
            default:
                break
            }
        case 1:
            if indexPath.row == 0 {
                cell.keyNameRecipeDetail.text = "Ingredientes :"
            } else {
                cell.keyNameRecipeDetail.text = " "
            }
            cell.nameRecipeDetail.text = self.recipe.ingredientes[indexPath.row]
        case 2:
            if indexPath.row == 0 {
                cell.keyNameRecipeDetail.text = "Pasos :"
            } else {
                cell.keyNameRecipeDetail.text = " "
            }
            cell.nameRecipeDetail.text = self.recipe.pasos[indexPath.row]
        default:
            break
        }
        
        return cell
    }
}

extension DetailViewController : UITableViewDelegate {
    
}
