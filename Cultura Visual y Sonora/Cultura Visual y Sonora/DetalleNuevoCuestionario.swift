//
//  DetalleNuevoCuestionario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/19/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class DetalleNuevoCuestionario: UIViewController, protocoloAgregaPreg {
    
    @IBOutlet weak var tfNombreCuest: UITextField!
    @IBOutlet weak var tfTiempoCuest: UITextField!

    var listaPreguntas:[Pregunta] = [Pregunta]()
    var cantPreg : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func creaCuestionario() {
        let nomb = tfNombreCuest.text
        let tiem:Double = (tfTiempoCuest.text! as NSString).doubleValue
        
        let nuevoCuestionario = Cuestionario(nom: nomb!, numPreg: cantPreg, preg: listaPreguntas, tiempo: tiem)
        
        for preg in nuevoCuestionario.preguntas {
            print(preg.descripcion)
        }
        
        guardarCuestionario(cuest: nuevoCuestionario)
        
    }
    
    //MARK: - Firebase
    func guardarCuestionario(cuest: Cuestionario) {
        let colRef = Firestore.firestore().collection("Cuestionarios")
        
        colRef.document("\(cuest.nombre)").setData([
            "nombre": cuest.nombre,
            "tiempo": cuest.tiempoCuestionario,
            "preguntas": [],
            "cantPreguntas": cuest.preguntas.count
        ])
        
        var i=1
        for preg in cuest.preguntas {
            guardarPregunta(cuest: cuest, preg: preg, i: i)
            i += 1
        }
    }
    
    func guardarPregunta(cuest: Cuestionario, preg: Pregunta, i: Int) {
        let cuestRef = Firestore.firestore().collection("Cuestionarios").document("\(cuest.nombre)")
        
        cuestRef.updateData([
            "preguntas": FieldValue.arrayUnion([
                [ "pregunta \(i)":
                    ["descripcion": preg.descripcion,
                     "categoria": preg.categoria,
                     "respuestas": [
                        preg.respuestas[0],
                        preg.respuestas[1],
                        preg.respuestas[2],
                        preg.respuestas[3]],
                     "respCorrecta": preg.respuestaCorrecta,
                     "imagenes": [],
                     "imagenPreg": "",
                     "tipoResp": preg.tipoRespuestas
                    ]
                ]
            ])
        ])
    }
    //guardarImagen(image: preg.imgPregunta, cuest: cuest, i: i)

    func guardarImagen(image: UIImage?, cuest: Cuestionario, i: Int) {
        print("1")
        guard let data = image?.jpegData(compressionQuality: 1.0) else {
            let alerta = UIAlertController(title: "Error", message: "Algo salio mal 1", preferredStyle: .alert)
            let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alerta.addAction(accion)
            
            self.present(alerta, animated: true, completion: nil)
            return
        }
        
        let imgName = "\(cuest.nombre)Preg\(i).jpeg"
        let imageReference = Storage.storage().reference(withPath: "images/\(imgName)")
        
        print("2")
        imageReference.putData(data, metadata:nil) { (metadata, error) in
            if let error = error {
                let alerta = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                self.present(alerta, animated: true, completion: nil)
                return
            }
            print("Put is complete and i got this back \(metadata)")
            
            print("3")
            /*imageReference.downloadURL(completion: { (url, error) in
                if let error = error {
                    let alerta = UIAlertController(title: "Error", message: "Algo salio mal 3", preferredStyle: .alert)
                    let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alerta.addAction(accion)
                    
                    self.present(alerta, animated: true, completion: nil)
                    return
                }
                
                print("4")
                guard let url = url else {
                    let alerta = UIAlertController(title: "Error", message: "Algo salio mal 4", preferredStyle: .alert)
                    let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alerta.addAction(accion)
                    
                    self.present(alerta, animated: true, completion: nil)
                    return
                }
                
                let urlString = url.absoluteString
                print(urlString)
                
                print("5")
                let dataReference = Firestore.firestore().collection("Cuestionarios").document("\(cuest.nombre)")
                dataReference.updateData([
                    "imagenPreg": urlString
                ]) { (error) in
                    let alerta = UIAlertController(title: "Error", message: "Algo salio mal 5", preferredStyle: .alert)
                    let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alerta.addAction(accion)
                    
                    self.present(alerta, animated: true, completion: nil)
                    return
                }
                let alerta = UIAlertController(title: "Success", message: "Updated imagen pregunta", preferredStyle: .alert)
                let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                self.present(alerta, animated: true, completion: nil)
            })*/
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewPreguntas = segue.destination as! CreacionCuestionario
        viewPreguntas.delegado = self
    }
    
    func agregaPreguntas(pregs: [Pregunta]) {
        listaPreguntas = pregs
        creaCuestionario()
    }

}
