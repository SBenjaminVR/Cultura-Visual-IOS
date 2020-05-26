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
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbContrasena: UILabel!
    @IBOutlet weak var btnCuenta: UIButton!
    @IBOutlet weak var btnEntrar: UIButton!
    @IBOutlet weak var btnCreditos: UIButton!
    
    var docRef: DocumentReference!
    var uName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        var maximoFont: CGFloat
        
        if (width > 1125) {
            maximoFont = 30
        }
        else {
            maximoFont = 17
        }
        let tamMax = ajustarFontSize(label: lbUsername, bold: true, maxSize: maximoFont)
        ajustarFontSize(label: lbContrasena, bold: true, maxSize: tamMax)
        ajustarFontSize(label: btnCuenta.titleLabel!, bold: false, maxSize: maximoFont)
        ajustarFontSize(label: btnEntrar.titleLabel!, bold: false, maxSize: maximoFont)
        ajustarFontSize(label: btnCreditos.titleLabel!, bold: false, maxSize: maximoFont)
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func ajustarFontSize(label: UILabel, bold: Bool, maxSize: CGFloat) -> CGFloat {
        let maxFontSize: CGFloat = maxSize
        let minFontSize: CGFloat = 10

        if bold {
            label.font = UIFont(name: "HelveticaNeue-Bold", size: maxFontSize)!
        }
        else {
            label.font = UIFont(name: "HelveticaNeue", size: maxFontSize)!
        }
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = minFontSize/maxFontSize
        
        return label.font.pointSize
    }
    

    @IBAction func logIn(_ sender: UIButton) {
        let textUser = self.tfUser.text!
        let textPassword = self.tfPassword.text!
        
        if textPassword != "" && textUser != "" {
            uName = tfUser.text!
            tfUser.text = ""
            tfPassword.text = ""
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
        } else {
            let alerta = UIAlertController(title: "Error", message: "No puede haber campos vacios", preferredStyle: .alert)
            let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alerta.addAction(accion)
            
            self.present(alerta, animated: true, completion: nil)
        }
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
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "alumno" {
            let vista = segue.destination as! MenuPrincipalAlumno
            vista.nombreUsuario = uName!
        }
    }
}

