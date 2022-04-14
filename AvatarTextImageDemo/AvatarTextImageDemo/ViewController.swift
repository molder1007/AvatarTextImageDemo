//
//  ViewController.swift
//  AvatarTextImageDemo
//
//  Created by Molder on 2022/4/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var avatarTextImageView: UIImageView!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImage()
    }
    
    private func setUpImage() {
        avatarTextImageView.clipsToBounds = true
        avatarTextImageView.layer.cornerRadius = avatarTextImageView.bounds.width / 2
        avatarTextImageView.layer.borderWidth = 1
        avatarTextImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

    @IBAction func createAction(_ sender: UIButton) {
        // TextField 輸入的姓
        let lastName = lastNameTextField.text ?? ""
        // TextField 輸入的名
        let firstName = firstNameTextField.text ?? ""
        // 根據規則組合姓名文字，如果不符合規則，圖片就放預設圖
        guard let name = RegularExp().getRegExpName(firstName: firstName, lastName: lastName) else {
            // 顯示預設圖
            avatarTextImageView.image = UIImage(named: "user")
            return }
        // 產生文字圖
        avatarTextImageView.image = UIImage().createAvatarTextImage(text: name, imageSize: CGSize(width: avatarTextImageView.bounds.width, height: avatarTextImageView.bounds.height), imageBackgroundColor: UIColor.lightGray, textFont: UIFont.boldSystemFont(ofSize: 50), textFontColor: .white)
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        avatarTextImageView.image = UIImage(named: "user")
    }
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
