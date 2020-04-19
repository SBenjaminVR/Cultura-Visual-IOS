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
    
    var delegado : protocoloAgregaPreg!
    var listaPreguntas : [Pregunta] = [Pregunta]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Creacion Preguntas
    @IBAction func agregarPregunta(_ sender: UIButton) {
        //Atributos para la nueva pregunta
        let descrip = tfPregunta.text!
        let respuestas:[String] = [tfRespuesta1.text!, tfRespuesta2.text!, tfRespuesta3.text!, tfRespuesta4.text!]
        let corr = 1
        var tipoPreg:String
        if tipoPreguntas.selectedSegmentIndex == 0 {
            tipoPreg = "multiple"
        } else {
            tipoPreg = "V/F"
        }
        let images:[UIImage] = [imgR1.image!, imgR2.image!, imgR3.image!, imgR4.image!]
        var categoria:String
        if tipoRespuestas.selectedSegmentIndex == 0 {
            categoria = "texto"
        } else {
            categoria = "imagenes"
        }
        let fotoPreg = imgPreg.image
                
        //Se crea el objeto Pregunta
        let newPreg = Pregunta(desc: descrip, resp: respuestas, correcta: corr, tipo: tipoPreg, imgs: images, categ: categoria, imgPreg: fotoPreg)
        
        //Se actualiza el Cuestionario con la nueva pregunta
        listaPreguntas.append(newPreg)
        
        //Se limpian los campos para la siguiente pregunta
        tipoRespuestas.selectedSegmentIndex = 0
        tipoPreguntas.selectedSegmentIndex = 0
        
        tfPregunta.text = ""
        tfRespuesta1.text = ""
        tfRespuesta2.text = ""
        tfRespuesta3.text = ""
        tfRespuesta4.text = ""
        
        imgPreg.image = UIImage(named: "default")
        imgR1.image = UIImage(named: "default")
        imgR2.image = UIImage(named: "default")
        imgR3.image = UIImage(named: "default")
        imgR4.image = UIImage(named: "default")
    }
    
    // MARK: - Creacion Cuestionario
    @IBAction func crearCuestionario(_ sender: UIButton) {
        delegado.agregaPreguntas(pregs: listaPreguntas)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - ImagePickerDelegate
    
    @IBAction func agregarFoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let foto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imgPreg.image = foto
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
