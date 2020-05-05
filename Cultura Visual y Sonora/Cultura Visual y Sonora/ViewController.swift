//
//  ViewController.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    var docRef: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }

    @IBAction func logIn(_ sender: UIButton) {
        let textUser = self.tfUser.text!
        let textPassword = self.tfPassword.text!
        docRef = Firestore.firestore().document("Users/\(textUser)")
        
        docRef.getDocument(completion: { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else {
                print("No Document")
                let alerta = UIAlertController(title: "Error", message: "Usuario no existe", preferredStyle: .alert)
                let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                self.present(alerta, animated: true, completion: nil)
                return
            }
            let myData = docSnapshot.data()
            let username = myData!["username"] as? String ?? "(noUser)"
            let userType = myData!["tipoUsuario"] as? String ?? "(noType)"
            let password = myData!["password"] as? String ?? "(noPasswrd)"
            
            if password == textPassword {
                if userType == "Alumno" {
                    self.performSegue(withIdentifier: "alumno", sender: self)
                } else {
                    self.performSegue(withIdentifier: "maestro", sender: self)
                }
            } else {
                let alerta = UIAlertController(title: "Error", message: "Los datos no son correctos", preferredStyle: .alert)
                let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                self.present(alerta, animated: true, completion: nil)
            }
        })
    }
    
    func setBackground() -> Void {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    
    @IBAction func quitarTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}

