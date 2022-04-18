//
//  ViewController.swift
//  UpDownGame
//
//  Created by 강보현 on 2022/04/11.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables : Mutable
    // Constants : Immutable
    
    var randomValue: Int = 0
    var tryCount: Int = 0
    
    // stroyboard위에 있는 요소와 연결할 때 쓰는 어노테이션
    // 버튼 클릭 시 slider의 값을 사용하기 위한 Outlet변수
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!


    override func viewDidLoad() {
        // onCreate
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // slider 이미지 변경
        slider.setThumbImage(UIImage(named: "slider_thumb.png"), for: .normal)
        //for: .normal 평소에 저 이미지로 보여지도록 한다.
        reset()

    }
    
    // 인터페이스 빌더에 요소들이 이벤트를 받았을 때 반응하도록
    // 사용자가 슬라이드 잡아 끌 때 print value
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let integerValue: Int = Int(sender.value)
        sliderValueLabel.text = String(integerValue)
        print(sender.value)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (action) in self.reset()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    // 사용자가 버튼 클릭 할 때 print slider의 value
    @IBAction func touchUpHitButton(_ sender: UIButton) {
        print(slider.value)
        let hitValue: Int = Int(slider.value)
        // 소수점 떼고 정수로 만들기
        tryCount += 1
        tryCountLabel.text = "\(tryCount) / 5"
        print(tryCount)
        
        if randomValue == hitValue {
            showAlert(message: "You Win")
            reset()
        }
        else if tryCount >= 5 {
            showAlert(message: "You Lose")
            reset()
        }
        else if randomValue > hitValue {
            minimumValueLabel.text = String(hitValue)
            slider.value = (Float(hitValue) + slider.maximumValue) / 2
            slider.minimumValue = Float(hitValue)

        }
        else {
            maximumValueLabel.text = String(hitValue)
            slider.value = (Float(hitValue) + slider.minimumValue) / 2
            slider.maximumValue = Float(hitValue)
        }
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        reset()
    }
    
    func reset() {
        randomValue = Int.random(in: 0...30)
        slider.value = 15
        tryCount = 0
        tryCountLabel.text = "0 / 5"
        slider.minimumValue = 0
        slider.maximumValue = 30
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValueLabel.text = "15"
        print(randomValue)
        print("reset success")
    }
    

}

