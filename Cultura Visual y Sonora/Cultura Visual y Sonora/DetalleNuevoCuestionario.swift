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
        //var j=0
        for preg in cuest.preguntas {
            guardarPregunta(cuest: cuest, preg: preg, i: i)
            i += 1
        }
    }
    
    func guardarPregunta(cuest: Cuestionario, preg: Pregunta, i: Int) {
        let cuestRef = Firestore.firestore().collection("Cuestionarios").document("\(cuest.nombre)")
        
      
        cuestRef.updateData([
            "preguntas": FieldValue.arrayUnion([

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
                
            ])
        ])
        
        guardarImagen(image: preg.imgPregunta, cuest: cuest, i: i, tipo: 1, resp: 4)
        guardarImagen(image: preg.imagenes[0], cuest: cuest, i: i, tipo: 0, resp: 0)
        guardarImagen(image: preg.imagenes[1], cuest: cuest, i: i, tipo: 0, resp: 1)
        guardarImagen(image: preg.imagenes[2], cuest: cuest, i: i, tipo: 0, resp: 2)
        guardarImagen(image: preg.imagenes[3], cuest: cuest, i: i, tipo: 0, resp: 3)
    }
    
    
 func guardarImagen(image: UIImage, cuest: Cuestionario, i: Int, tipo: Int, resp: Int) {
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            let alerta = UIAlertController(title: "Error", message: "Algo salio mal 1", preferredStyle: .alert)
            let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alerta.addAction(accion)
            
            self.present(alerta, animated: true, completion: nil)
            return
        }
        
        var imgName = ""
            
        if tipo == 1 {
            imgName = "\(cuest.nombre)Preg\(i).jpeg"
        } else {
            imgName = "\(cuest.nombre)Preg\(i)Resp\(resp).jpeg"
        }
        let imageReference = Storage.storage().reference(withPath: "images/\(imgName)")
        
        imageReference.putData(data, metadata:nil) { (metadata, error) in
            if let error = error {
                let alerta = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                self.present(alerta, animated: true, completion: nil)
                return
            }
            
            imageReference.downloadURL(completion: { (url, error) in
                if let error = error {
                    let alerta = UIAlertController(title: "Error", message: "Algo salio mal 3", preferredStyle: .alert)
                    let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alerta.addAction(accion)
                    
                    self.present(alerta, animated: true, completion: nil)
                    return
                }
                
            
                guard let url = url else {
                    let alerta = UIAlertController(title: "Error", message: "Algo salio mal 4", preferredStyle: .alert)
                    let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alerta.addAction(accion)
                    
                    self.present(alerta, animated: true, completion: nil)
                    return
                }
                
                let urlString = url.absoluteString
                
                let dataReference = Firestore.firestore().collection("Cuestionarios").document("\(cuest.nombre)")
                if tipo == 1{
                    dataReference.updateData([
                        "preguntas.\(i).imagenPreg": urlString
                    ]) { (error) in
                        let alerta = UIAlertController(title: "Error", message: "Algo salio mal 5", preferredStyle: .alert)
                        let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        
                        alerta.addAction(accion)
                        
                        self.present(alerta, animated: true, completion: nil)
                        return
                    }
                }
                else{
                    dataReference.updateData([
                        "preguntas.\(i).imagenes": FieldValue.arrayUnion([urlString])
                    ]) { (error) in
                        let alerta = UIAlertController(title: "Error", message: "Algo salio mal 5", preferredStyle: .alert)
                        let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        
                        alerta.addAction(accion)
                        
                        self.present(alerta, animated: true, completion: nil)
                        return
                    }
                }
                
                
                
            })
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
