//
//  RegistroUsuario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit
import Firebase

class RegistroUsuario: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfCorreo: UITextField!
    @IBOutlet weak var tfContrasena: UITextField!
    @IBOutlet weak var tfConfirmar: UITextField!
    @IBOutlet weak var btnCancelar: UIButton!
    @IBOutlet weak var btnCrearCuenta: UIButton!
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbUsuario: UILabel!
    @IBOutlet weak var lbContrasena: UILabel!
    @IBOutlet weak var lbConfirmacion: UILabel!
    
    var docRef: DocumentReference!
    
    var activeField : UITextField!
    
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
        let tamMax = ajustarFontSize(label: lbNombre, bold: true, maxSize: maximoFont)
        ajustarFontSize(label: lbContrasena, bold: true, maxSize: tamMax)
        ajustarFontSize(label: lbUsuario, bold: true, maxSize: tamMax)
        ajustarFontSize(label: lbConfirmacion, bold: true, maxSize: tamMax)
        ajustarFontSize(label: btnCancelar.titleLabel!, bold: false, maxSize: maximoFont)
        ajustarFontSize(label: btnCrearCuenta.titleLabel!, bold: false, maxSize: maximoFont)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 && activeField != nil {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // Each text field in the interface sets the view controller as its delegate.
    // Therefore, when a text field becomes active, it calls these methods.
    func textFieldDidBeginEditing (_ textField : UITextField )
    {
        activeField = textField
        print(activeField)
    }
    
    func textFieldDidEndEditing (_ textField : UITextField )
    {
        activeField = nil
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
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
    
    func setBackground() -> Void {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background.png")
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
