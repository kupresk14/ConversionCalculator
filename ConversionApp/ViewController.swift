//
//  ViewController.swift
//  ConversionApp
//
//  Created by Xcode User on 9/18/19.
//  Copyright © 2019 cis.gvsu.edu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate{
   
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Allows user to touch anywhere on screen to remove keyboard view
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit) {
        fromLabel.text = "\(fromUnits)"
        toLabel.text = "\(toUnits)"
    }

    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit) {
        fromLabel.text = "\(fromUnits)"
        toLabel.text = "\(toUnits)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "settingsSeque"{
            if let dest = segue.destination as? SettingsViewController {
                dest.delegate = self
            }
        }
    }
    
    @IBAction func calcButton(_ sender: Any) {
        let fromMode:Double? = Double(self.fromField.text!)
        let toMode:Double? = Double(self.toField.text!);
        
        if(self.fromField.text != ""){
            let convKey = LengthConversionKey(toUnits: .Yards, fromUnits: .Meters);
            let yardAns = fromMode! * lengthConversionTable[convKey]!;
            self.toField.text = String(yardAns);
        }
        else if(self.toField.text != ""){
            let convKey = LengthConversionKey(toUnits: .Meters, fromUnits: .Yards)
            let meterAns = toMode! * lengthConversionTable[convKey]!
            self.fromField.text = String(meterAns)
        }
    }
    
    @IBAction func clearButton(_ sender: Any) {
        self.fromField.text = "";
        self.toField.text = "";
    }
    
    @IBAction func modeButton(_ sender: Any) {
        if(fromLabel.text == "Yards" && toLabel.text == "Meters"){
            fromLabel.text = "Gallons"
            toLabel.text = "Liters"
        }
        else{
            fromLabel.text = "Yards"
            toLabel.text = "Meters"
        }
    }
}

