//
//  RegistroUsuario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit
import Firebase

class RegistroUsuario: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfCorreo: UITextField!
    @IBOutlet weak var tfContrasena: UITextField!
    @IBOutlet weak var tfConfirmar: UITextField!
    
    var docRef: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
    }
    
    func setBackground() -> Void {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "shinyBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @IBAction func crearCuenta(_ sender: Any) {
        
        let nombre = String(tfNombre.text!)
        let correo = String(tfCorreo.text!)
        let contrasena = String(tfContrasena.text!)
        let confirmar = String(tfConfirmar.text!)
        
        if !nombre.isEmpty && !correo.isEmpty && !contrasena.isEmpty && !confirmar.isEmpty {
            
            if contrasena == confirmar {
                //Falta encriptar contraseña
                let nuevoUser = Usuario(nom: nombre, tipo: "Alumno", user: correo, passw: contrasena)
                
                //Guardar nuevo user en base de datos?
                docRef = Firestore.firestore().document("Users/\(nuevoUser.username)")
                
                let dataToSave: [String: Any] = ["nombre": nuevoUser.nombre, "username": nuevoUser.username, "password": nuevoUser.password, "tipoUsuario": "Alumno"]
                docRef.setData(dataToSave) { (error) in
                    if let error = error {
                        print("Got an error: \(error.localizedDescription)")
                    } else {
                        print("New user saved")
                    }
                }
                
                dismiss(animated: true, completion: nil)
            } else {
                let alerta = UIAlertController(title: "Error", message: "Los passwords no coinciden, trate de nuevo", preferredStyle: .alert)
                let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                self.present(alerta, animated: true, completion: nil)
            }
        }
        else {
            let alerta = UIAlertController(title: "Error", message: "Todos los campos deben de estar llenos", preferredStyle: .alert)
            let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alerta.addAction(accion)
            
            present(alerta, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func quitarTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
