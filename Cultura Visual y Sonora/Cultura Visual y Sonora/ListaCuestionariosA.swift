//
//  ListaCuestionariosA.swift
//  Cultura Visual y Sonora
//
//  Created by user168609 on 4/14/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ListaCuestionariosA: UITableViewController {
    
    var listaDatos = ["Arte", "Musica", "Arquitectura"]
    var listaCuestionarios : [Cuestionario] = [Cuestionario]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cuestionarios"
        //obtenerCuestionarios()
    }
    
    //MARK: - Firebase
    /*func obtenerCuestionarios() {
        let cuestRef = Firestore.firestore().collection("Cuestionarios")
            
        cuestRef.getDocuments(completion: { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                let alerta = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alerta.addAction(accion)
                
                self.present(alerta, animated: true, completion: nil)
                return
            }
            
            var nombre = ""
            var tiempo = 0
            var cantPreg = 0
            
            let documents = querySnapshot.documents
            for document in documents {
                nombre = document["nombre"] as? String ?? "(noName)"
                tiempo = document["tiempo"] as? Int ?? 0
                cantPreg = document["cantPreguntas"] as? Int ?? 0
            }
            
            let pregRef = Firestore.firestore().collection("Cuestionarios").document("\(nombre)").collection("Preguntas")
            
            pregRef.getDocuments(completion: { (querySnapshotP, error) in
                guard let querySnapshotP = querySnapshotP else {
                    let alerta = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alerta.addAction(accion)
                    
                    self.present(alerta, animated: true, completion: nil)
                    return
                }
                
                var categoria = ""
                var descripcion = ""
                var respCorrecta = 0
                var respuestas = [String]()
                var tipoResp = ""
                var imgPreg:UIImage!
                var imagenes = [UIImage]()
                var i = 0
                
                let pregDocs = querySnapshotP.documents
                for pregDoc in pregDocs {
                    categoria = pregDoc["categoria"] as? String ?? "noCateg"
                    descripcion = pregDoc["descripcion"] as? String ?? "noDesc"
                    respCorrecta = pregDoc["respCorrecta"] as? Int ?? 0
                    respuestas = pregDoc["respuestas"] as! [String]
                    tipoResp = pregDoc["tipoResp"] as? String ?? "noTipoRes"
                    
                    let imageRef = Storage.storage().reference().child("images/\(nombre)Preg\(i).jpeg")
                    imageRef.getData(maxSize: 1*10240*10240, completion: { (data, error) in
                        if let error = error {
                            let alerta = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                            let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                            
                            alerta.addAction(accion)
                            
                            self.present(alerta, animated: true, completion: nil)
                            return
                        } else {
                        
                            imgPreg = UIImage(data: data!)
                            
                            for j in 0...3 {
                                let imageRef2 = Storage.storage().reference().child("images/\(nombre)Preg\(i)Resp\(j).jpeg")
                                imageRef2.getData(maxSize: 1*10240*10240, completion: { (data2, error) in
                                    if let error = error {
                                        let alerta = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                                        let accion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                                        
                                        alerta.addAction(accion)
                                        
                                        self.present(alerta, animated: true, completion: nil)
                                        return
                                    } else {
                                        imagenes.append(UIImage(data: data2!)!)
                                        print("------------------------")
                                        print(imagenes)
                                    }
                                })
                            }
                            print("***********************************")
                            print(imagenes)
                            i+=1
                        }
                    })
                }
                
                
                
            })
        })
    }*/

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaDatos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellCuestionario", for: indexPath)

        cell.textLabel?.text = listaDatos[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
