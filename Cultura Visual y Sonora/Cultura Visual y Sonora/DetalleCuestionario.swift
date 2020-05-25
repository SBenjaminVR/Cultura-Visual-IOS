//
//  DetalleCuestionario.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class DetalleCuestionario: UIViewController, protocoloRespuestasUsuario {
    
    var nombreUsuario:String!
    var cuestionarioSeleccionado : Cuestionario!
    var NumeroDeRespuestas:Int!
    var respuestasUsuario : [Int]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(cuestionarioSeleccionado.nombre)"
        
        obtenerPreguntas(addPreguntas, nombre: cuestionarioSeleccionado.nombre)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func obtenerPreguntas(_ completion: @escaping ([QueryDocumentSnapshot], String)->Void, nombre: String) {
        let pregRef = Firestore.firestore().collection("Preguntas")
        let cuestRef = pregRef.whereField("cuestionario", isEqualTo: nombre)
            
        if nombre != "CuestGeneral" {
            cuestRef.getDocuments(completion: { (querySnapshotP, error) in
                guard let querySnapshotP = querySnapshotP else {
                    let alerta = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alerta.addAction(accion)
                    
                    self.present(alerta, animated: true, completion: nil)
                    return
                }
                
                let pregDocs = querySnapshotP.documents
                completion(pregDocs, nombre)
            })
        } else {
            pregRef.getDocuments(completion: { (querySnapshotP, error) in
                guard let querySnapshotP = querySnapshotP else {
                    let alerta = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alerta.addAction(accion)
                    
                    self.present(alerta, animated: true, completion: nil)
                    return
                }
                
                let pregDocs = querySnapshotP.documents
                completion(pregDocs, nombre)
            })
        }
        
        
    }

    
    func addPreguntas(preguntas: [QueryDocumentSnapshot], nombre:String) {
        var categoria = ""
        var descripcion = ""
        var respCorrecta = 0
        var respuestas = [String]()
        var tipoResp = ""
        var imgPreg:UIImage!
        var imagenes = [UIImage]()
        var j = 0
        var sUrl:String!
        var url:URL!
        var imgRespData:NSData!
        
        for pregDoc in preguntas {
            categoria = pregDoc["categoria"] as? String ?? "noCateg"
            descripcion = pregDoc["descripcion"] as? String ?? "noDesc"
            respCorrecta = pregDoc["respCorrecta"] as? Int ?? 0
            respuestas = pregDoc["respuestas"] as! [String]
            tipoResp = pregDoc["tipoResp"] as? String ?? "noTipoRes"
            
            let nuevaPregunta = Pregunta(desc: descripcion, resp: respuestas, correcta: respCorrecta, tipo: tipoResp, categ: categoria)
            
            sUrl = pregDoc["imagenPreg"] as? String ?? "noImgPregString"
            
            if sUrl != "" {
                url = URL(string: sUrl)
                let imgData = NSData(contentsOf: url!)
                nuevaPregunta.setImagenPregunta(imgPreg: UIImage(data: imgData! as Data))
            } else {
                nuevaPregunta.setImagenPregunta(imgPreg: UIImage(named: "default"))
            }
            
            let imgsArr = pregDoc["imagenes"] as? [String]
            
            if imgsArr!.count != 0 {
                for k in 0...imgsArr!.count-1 {
                    url = URL(string: imgsArr![k])
                    imgRespData = NSData(contentsOf: url!)
                    nuevaPregunta.imagenes.append(UIImage(data: imgRespData! as Data)!)
                }
            }
            
            cuestionarioSeleccionado.preguntas.append(nuevaPregunta)
            j += 1
        }
        
        
        
        setBackground()
        
        if cuestionarioSeleccionado.nombre == "CuestGeneral" && cuestionarioSeleccionado.numeroDePreguntas != 0 {
            configuraPreguntasGeneral()
        } else {
            if cuestionarioSeleccionado.nombre == "CuestGeneral" {
                cuestionarioSeleccionado.preguntas.shuffle()
            }
            cuestionarioSeleccionado.numeroDePreguntas = cuestionarioSeleccionado.preguntas.count
        }
        
        NumeroDeRespuestas = cuestionarioSeleccionado.numeroDePreguntas
        if respuestasUsuario == nil {
            respuestasUsuario = Array(repeating: 0, count: NumeroDeRespuestas)
        }
    }
    
    func configuraPreguntasGeneral() {
        cuestionarioSeleccionado.preguntas.shuffle()
        
        var tempPreg : [Pregunta] = [Pregunta]()
        
        for i in 0...cuestionarioSeleccionado.numeroDePreguntas-1 {
            if i >= cuestionarioSeleccionado.preguntas.count {
                break
            }
            
            tempPreg.append(cuestionarioSeleccionado.preguntas[i])
        }
        
        cuestionarioSeleccionado.addQuestions(preguntas: tempPreg)
    }
        
    func setBackground() -> Void {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "shinyBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func guardaRespuestasUsuario(resps: [Int], tiempo: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nombreUsuario, forKey: "username")
        userDefaults.set(cuestionarioSeleccionado.nombre, forKey: "cuestionario")
        userDefaults.set(true, forKey: "hasLeft")
        userDefaults.set(tiempo, forKey: "timer")
        userDefaults.set(resps, forKey: "respuestas")
        respuestasUsuario = resps
    }
    

    @IBAction func reiniciaRespuestasUsuario(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(false, forKey: "hasLeft")
        userDefaults.set(0, forKey: "timer")
        for i in 0...respuestasUsuario.count-1 {
            respuestasUsuario[i] = 0
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vistaDestino = segue.destination as! RespondeCuestionario
            
        let userDefaults = UserDefaults.standard
        let hasLeft = userDefaults.bool(forKey: "hasLeft")
        let user = userDefaults.string(forKey: "username")
        let cuestionario = userDefaults.string(forKey: "cuestionario")
        
        if hasLeft && user == nombreUsuario && cuestionario == cuestionarioSeleccionado.nombre {
            vistaDestino.timerCounter = userDefaults.integer(forKey: "timer")
            vistaDestino.respuestasUsuario = userDefaults.array(forKey: "respuestas") as? [Int]
        }
        else {
            vistaDestino.respuestasUsuario = respuestasUsuario
        }
        
        vistaDestino.cuestionarioACargar = cuestionarioSeleccionado
        vistaDestino.delegado = self
        vistaDestino.nombreUsuario = nombreUsuario
    }
    
    @IBAction func regresarCuestionarios(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
