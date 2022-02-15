//
//  ViewController.swift
//  Storage capacity calculator
//
//  Created by ak77m on 03.10.2020.
//

import UIKit

final class CalculatorController: UIViewController {
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var minLabel: UILabel!
    @IBOutlet private weak var maxLabel: UILabel!
    @IBOutlet private weak var magazinesNumberLabel: UILabel!
    @IBOutlet private weak var raidLevel: UISegmentedControl!
    @IBOutlet private weak var capacitySlider: UISlider!
    @IBOutlet private weak var recommendedNumber: UISegmentedControl!
    @IBOutlet private weak var systemSelector: UISegmentedControl!
    
    // Default configuration
    var calculator = Calculator(magazinesNumber: 152, raid: 3, volume: 3.6, system: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // default values for elements
        raidLevel.selectedSegmentIndex = 3
        systemSelector.selectedSegmentIndex = 1
        recommendedNumber.selectedSegmentIndex = 1
        raidLevel.selectedSegmentIndex = 3
        updateUI()
    }
    
    @IBAction func systemSelectorAction(_ sender: UISegmentedControl) {
        calculator.currentSystem = sender.selectedSegmentIndex
        updateUI()
    }
    
    @IBAction func recommendedNumberAction(_ sender: UISegmentedControl) {
        guard let value = sender.titleForSegment(at: sender.selectedSegmentIndex) else {
            return
        }
        calculator.magazinesNumber = Int(value) ?? 0
        updateUI()
    }
    
    @IBAction func raidLevelAction(_ sender: UISegmentedControl) {
        let level = sender.selectedSegmentIndex
        calculator.raidLevel = level
        updateUI()
    }
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        recommendedNumber.selectedSegmentIndex = UISegmentedControl.noSegment
        calculator.magazinesNumber = Int(sender.value)
        updateUI()
    }
    
   private func updateUI() {
        calculator.selectedVolume = calculator.volume()
        let maxCapacity = calculator.maxCapacity()
        let totalVolume =  calculator.totalVolume
        
        capacitySlider.value = Float(calculator.magazinesNumber)
        minLabel.text = "0 TB"
        maxLabel.text = "\(maxCapacity) TB"
        magazinesNumberLabel.text = "Number of magazines: \(calculator.magazinesNumber) pcs"
        
        let capacityStr = String(format: "%.1f", totalVolume)
        if calculator.raidLevel == 3 {
            resultLabel.text = capacityStr + " TB\n unformatted volume"
        } else {
            resultLabel.text = capacityStr + " TB\n logical volume "
        }
        
    }
    
    @IBAction func calcButtonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.calcSeque, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.calcSeque {
            guard let destinationVC = segue.destination as? ResultViewController else {return}
            destinationVC.magazines = calculator.magazinesNumber
            destinationVC.system = calculator.currentSystem
        }
    }
    
}

// MARK: - NavigationBarHidden

extension CalculatorController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
