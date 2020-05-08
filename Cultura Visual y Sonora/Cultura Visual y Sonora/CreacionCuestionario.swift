//
//  CreacionCuestionario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

protocol protocoloAgregaPreg {
    func agregaPreguntas(pregs: [Pregunta]) -> Void
}

class CreacionCuestionario: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Variables
    
    @IBOutlet weak var tipoPreguntas: UISegmentedControl! //Segmented Control para mostrar el tipo de Preguntas
    @IBOutlet weak var tipoRespuestas: UISegmentedControl! //Segmented Control para mostrar el tipo de Respuestas
    
    //Imagenes para preguntas
    @IBOutlet weak var imgR1: UIImageView!
    @IBOutlet weak var imgR2: UIImageView!
    @IBOutlet weak var imgR3: UIImageView!
    @IBOutlet weak var imgR4: UIImageView!
    @IBOutlet weak var imgPreg: UIImageView!
    
    //TextFields para cargar imagen
    @IBOutlet weak var tfRespuesta1: UITextField!
    @IBOutlet weak var tfRespuesta2: UITextField!
    @IBOutlet weak var tfRespuesta3: UITextField!
    @IBOutlet weak var tfRespuesta4: UITextField!
    @IBOutlet weak var tfPregunta: UITextField! //Text Field para la pregunta
    
    @IBOutlet weak var btnAgregarPregunta: UIButton! //Boton para agregrar pregunta a arreglo de preguntas
    
    @IBOutlet weak var btnCrearCuestionario: UIButton! //Boton para crear el cuestionario
    
    //Outlets para taps
    @IBOutlet var tapFotoPreg: UITapGestureRecognizer!
    @IBOutlet var tapFotoR1: UITapGestureRecognizer!
    @IBOutlet var tapFotoR2: UITapGestureRecognizer!
    @IBOutlet var tapFotoR3: UITapGestureRecognizer!
    @IBOutlet var tapFotoR4: UITapGestureRecognizer!
    
    @IBOutlet weak var btnRespCorrecta1: UIButton!
    @IBOutlet weak var btnRespCorrecta2: UIButton!
    @IBOutlet weak var btnRespCorrecta3: UIButton!
    @IBOutlet weak var btnRespCorrecta4: UIButton!
    
    var selectedTap:Int!
    var corr:Int = 0
    
    var delegado : protocoloAgregaPreg!
    var listaPreguntas : [Pregunta] = [Pregunta]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgR1.isUserInteractionEnabled = false
        imgR2.isUserInteractionEnabled = false
        imgR3.isUserInteractionEnabled = false
        imgR4.isUserInteractionEnabled = false
    }
    
    // MARK: - Creacion Preguntas
    @IBAction func agregarPregunta(_ sender: UIButton) {
        
        var reset:Bool = false
        
        var tipoPreg:String
        if tipoPreguntas.selectedSegmentIndex == 0 {
            tipoPreg = "multiple"
        } else {
            tipoPreg = "V/F"
        }
        
        print("'\(( (imgR1.image?.isEqual(UIImage(named: "default")!))!))'")
        
        var categoria:String
        if tipoRespuestas.selectedSegmentIndex == 0 {
            categoria = "texto"
            
            if tfPregunta.text == "" || tfRespuesta1.text == "" || tfRespuesta2.text == "" || tfRespuesta3.text == "" || tfRespuesta4.text == "" {
                
                let alerta = UIAlertController(title: "Error", message: "Se deben llenar todos los campos de texto de respuestas y llenar la pregunta.", preferredStyle: .alert)
                let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                self.present(alerta, animated: true, completion: nil)
                                                
            } else {
                
                let descrip = tfPregunta.text!
                let respuestas:[String] = [tfRespuesta1.text!, tfRespuesta2.text!, tfRespuesta3.text!, tfRespuesta4.text!]
                let images:[UIImage] = [imgR1.image!, imgR2.image!, imgR3.image!, imgR4.image!]
                
                let fotoPreg = imgPreg.image
                
                let newPreg = Pregunta(desc: descrip, resp: respuestas, correcta: corr, tipo: tipoPreg, categ: categoria)
                newPreg.setImagenPregunta(imgPreg: fotoPreg)
                newPreg.setImagenesRespuestas(imgs: images)
                
                listaPreguntas.append(newPreg)
                reset = true
            }
            
        } else {
            categoria = "imagenes"
            
            if let imgR1 = imgR1, let imgR2=imgR2, let imgR3=imgR3, let imgR4=imgR4, ( (imgR1.image?.isEqual(UIImage(named: "default")!))! || (imgR2.image?.isEqual(UIImage(named: "default")!))! || (imgR3.image?.isEqual(UIImage(named: "default")!))! || (imgR4.image?.isEqual(UIImage(named: "default")!))! || tfPregunta.text == "")  {
                
                let alerta = UIAlertController(title: "Error", message: "Se deben cambiar todas las imagenes y llenar la preugntas.", preferredStyle: .alert)
                let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                self.present(alerta, animated: true, completion: nil)
                                
            } else {
                
                let descrip = tfPregunta.text!
                let respuestas:[String] = ["", "", "", ""]
                let images:[UIImage] = [imgR1.image!, imgR2.image!, imgR3.image!, imgR4.image!]
                
                let fotoPreg = imgPreg.image
                
                let newPreg = Pregunta(desc: descrip, resp: respuestas, correcta: corr, tipo: tipoPreg, categ: categoria)
                newPreg.setImagenPregunta(imgPreg: fotoPreg)
                newPreg.setImagenesRespuestas(imgs: images)
                
                listaPreguntas.append(newPreg)
                reset = true
            }
        }
        
        //Se limpian los campos para la siguiente pregunta
        if reset {
            tipoRespuestas.selectedSegmentIndex = 0
            tipoPreguntas.selectedSegmentIndex = 0
            
            tfPregunta.text = ""
            tfRespuesta1.text = ""
            tfRespuesta2.text = ""
            tfRespuesta3.text = ""
            tfRespuesta4.text = ""
            
            imgR1.isUserInteractionEnabled = false
            imgR2.isUserInteractionEnabled = false
            imgR3.isUserInteractionEnabled = false
            imgR4.isUserInteractionEnabled = false
            
            tfRespuesta1.isEnabled = true
            tfRespuesta2.isEnabled = true
            tfRespuesta3.isEnabled = true
            tfRespuesta4.isEnabled = true
            
            imgPreg.image = UIImage(named: "default")
            imgR1.image = UIImage(named: "default")
            imgR2.image = UIImage(named: "default")
            imgR3.image = UIImage(named: "default")
            imgR4.image = UIImage(named: "default")
            
            btnRespCorrecta1.setImage(UIImage(named: "Check"), for: .normal)
            btnRespCorrecta2.setImage(UIImage(named: "Uncheck"), for: .normal)
            btnRespCorrecta3.setImage(UIImage(named: "Uncheck"), for: .normal)
            btnRespCorrecta4.setImage(UIImage(named: "Uncheck"), for: .normal)
        }
    }
    
    // MARK: - Creacion Cuestionario
    @IBAction func crearCuestionario(_ sender: UIButton) {
        delegado.agregaPreguntas(pregs: listaPreguntas)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - ImagePickerDelegate
    @IBAction func agregarFoto(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        if sender == tapFotoPreg {
            selectedTap = 0
        } else if sender == tapFotoR1 {
            selectedTap = 1
        } else if sender == tapFotoR2 {
            selectedTap = 2
        } else if sender == tapFotoR3 {
            selectedTap = 3
        } else if sender == tapFotoR4 {
            selectedTap = 4
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let foto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        choosePhoto(foto: foto)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func choosePhoto(foto: UIImage) {
        if selectedTap == 0 {
            imgPreg.image = foto
        } else if selectedTap == 1 {
            imgR1.image = foto
        } else if selectedTap == 2 {
            imgR2.image = foto
        } else if selectedTap == 3 {
            imgR3.image = foto
        } else if selectedTap == 4 {
            imgR4.image = foto
        }
    }
    
    
    @IBAction func changeQuestionType(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tfRespuesta1.text = ""
            tfRespuesta2.text = ""
            
            tfRespuesta3.isEnabled = true
            tfRespuesta4.isEnabled = true
        } else {
            tipoRespuestas.selectedSegmentIndex = 0
            
            tfRespuesta1.text = "Verdadero"
            tfRespuesta2.text = "Falso"
            
            tfRespuesta3.isEnabled = false
            tfRespuesta4.isEnabled = false
            
        }
    }
    
    @IBAction func changeAnswerType(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0  {
            imgR1.isUserInteractionEnabled = false
            imgR2.isUserInteractionEnabled = false
            imgR3.isUserInteractionEnabled = false
            imgR4.isUserInteractionEnabled = false
            
            tfRespuesta1.isEnabled = true
            tfRespuesta2.isEnabled = true
            tfRespuesta3.isEnabled = true
            tfRespuesta4.isEnabled = true
        } else {
            tipoPreguntas.selectedSegmentIndex = 0
            imgR1.isUserInteractionEnabled = true
            imgR2.isUserInteractionEnabled = true
            imgR3.isUserInteractionEnabled = true
            imgR4.isUserInteractionEnabled = true
            
            tfRespuesta1.isEnabled = false
            tfRespuesta2.isEnabled = false
            tfRespuesta3.isEnabled = false
            tfRespuesta4.isEnabled = false
            
            tfRespuesta1.text = ""
            tfRespuesta2.text = ""
            tfRespuesta3.text = ""
            tfRespuesta4.text = ""
        }
    }
    
    @IBAction func seleccionaRespCorrecta(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Check"), for: .normal)
        
        if(sender == btnRespCorrecta1) {
            btnRespCorrecta2.setImage(UIImage(named: "Uncheck"), for: .normal)
            btnRespCorrecta3.setImage(UIImage(named: "Uncheck"), for: .normal)
            btnRespCorrecta4.setImage(UIImage(named: "Uncheck"), for: .normal)
            
            corr = 1;
            
        } else if(sender == btnRespCorrecta2) {
            btnRespCorrecta1.setImage(UIImage(named: "Uncheck"), for: .normal)
            btnRespCorrecta3.setImage(UIImage(named: "Uncheck"), for: .normal)
            btnRespCorrecta4.setImage(UIImage(named: "Uncheck"), for: .normal)
            
            corr = 2
            
        } else if(sender == btnRespCorrecta3) {
            btnRespCorrecta1.setImage(UIImage(named: "Uncheck"), for: .normal)
            btnRespCorrecta2.setImage(UIImage(named: "Uncheck"), for: .normal)
            btnRespCorrecta4.setImage(UIImage(named: "Uncheck"), for: .normal)
            
            corr = 3
            
        } else if(sender == btnRespCorrecta4) {
            btnRespCorrecta1.setImage(UIImage(named: "Uncheck"), for: .normal)
            btnRespCorrecta2.setImage(UIImage(named: "Uncheck"), for: .normal)
            btnRespCorrecta3.setImage(UIImage(named: "Uncheck"), for: .normal)
            
            corr = 4
        }
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
