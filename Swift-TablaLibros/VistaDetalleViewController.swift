//
//  VistaDetalleViewController.swift
//  Swift-TablaLibros
//
//  Created by Gerardo Valencia on 1/15/16.
//  Copyright © 2016 Gerardo Valencia. All rights reserved.
//

import UIKit

var tit = ""
var aut = ""
var ima : UIImage? = nil

class VistaDetalleViewController: UIViewController {

    
    var indice = 0
    
    @IBOutlet weak var Titulo: UITextView!
    @IBOutlet weak var Autor: UITextView!
    @IBOutlet weak var Imagen: UIImageView!
    @IBOutlet weak var IBN: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Titulo.text = tit
        Autor.text = aut
        Imagen.image = ima
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func Search(sender: AnyObject) {
        
        Start()
        textFieldShouldReturn(IBN)
    }

    func Start()
    {
        
        self.Imagen.image = nil
        self.Titulo.text = "-"
        self.Autor.text = "-"
        let textobox = IBN.text
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let url = NSURL(string: urls + textobox!)
        let datos = NSData(contentsOfURL: url!)
        
        if (datos == nil)
        {
            let alertController = UIAlertController(title: "Internet Error", message:
                "Verify internet connection and retry ", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        if (datos != nil)
        {
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                
                let dico1 = json as! NSDictionary
                
                if (dico1.count != 0)
                {
                    let dico2 = dico1["ISBN:" + IBN.text!] as! NSDictionary
                    
                    var cadena = ""
                    
                    for (var i=0;i<dico2["authors"]!.count;i++)
                    {
                        let sigue = dico2["authors"]![i]["name"] as! NSString as String
                        cadena = cadena + sigue + "\n"
                    }
                    
                    if (dico2["cover"] != nil)
                    {
                        let dico4 = dico2["cover"] as! NSDictionary
                        let url0 = NSURL(string: dico4["small"] as! NSString as String)
                        let data0 = NSData(contentsOfURL: url0!)
                        self.Imagen.image = UIImage(data: data0!)
                        ima = UIImage(data: data0!)
                    }
                    self.Titulo.text = dico2["title"] as! NSString as String
                    titulo = dico2["title"] as! NSString as String
                    self.Autor.text = cadena
                    autor = cadena
                    tit = titulo
                    aut = autor
                    
                    libros.append([titulo,autor])
                    
                    if(ima != nil)
                    {
                        imagenes.append(ima!)
                    }
                    else
                    {
                        imagenes.append(UIImage(named: "Empty.png")!)
                    }
                    
                }
                
            }
            catch _ {
                
                let alertController = UIAlertController(title: "Internet Error", message:
                    "Verify internet connection and retry ", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        }
        
        
        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "Atras")
        {
            
            let anterior = segue.destinationViewController  as! TVC
            anterior.tableView.beginUpdates()
            anterior.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: libros.count-1, inSection: 0)], withRowAnimation: .Automatic)
            anterior.tableView.endUpdates()
            anterior.tableView.reloadData()
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    

}
