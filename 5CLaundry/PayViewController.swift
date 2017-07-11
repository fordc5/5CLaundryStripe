//
//  PayViewController.swift
//  5CLaundry
//
//  Created by Ethan Hardacre on 7/10/17.
//  Copyright © 2017 5CLaundry. All rights reserved.
//

import UIKit
import Stripe
import CreditCardForm
import Alamofire

class PayViewController: UIViewController , STPPaymentCardTextFieldDelegate{
    
    var amountToPay = "0"
    var labelText = ""
    let paymentTextField = STPPaymentCardTextField()
    
    @IBOutlet weak var creditCardForm: CreditCardFormView!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    
    @IBAction func purchaseAction(_ sender: Any) {
        let card = paymentTextField.cardParams
        STPAPIClient.shared().createToken(withCard: card, completion: {(token, error) -> Void in
            if let error = error {
                print(error)
            }
            else if let token = token {
                print(token)
                self.chargeUsingToken(token: token)
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.]
        
        purchaseButton.layer.cornerRadius = purchaseButton.frame.height / 2
        payLabel.text = labelText
        
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true
        
        view.addSubview(paymentTextField)
        
        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: creditCardForm.bottomAnchor, constant: 20),
            paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
            paymentTextField.heightAnchor.constraint(equalToConstant: 44)
            ])
        
        paymentTextField.delegate = self
        self.purchaseButton.isHidden = true
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationYear, cvc: textField.cvc)
        if textField.valid {
            purchaseButton.isHidden = false;
        }
    }
    
    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
    }
    
    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidBeginEditingCVC()
    }
    
    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardForm.paymentCardTextFieldDidEndEditingCVC()
    }
    
    func chargeUsingToken(token: STPToken){
        let requestString = "https://shrouded-waters-57874.herokuapp.com/charge.php"
        let params = ["stripeToken": token.tokenId, "amount": amountToPay, "currency": "usd", "description": "testRun"]
        
        Alamofire.request(requestString , method: .post , parameters: params).responseJSON { response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
