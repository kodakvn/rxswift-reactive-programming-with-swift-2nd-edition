//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

example(of: "Challenge 1") {
    
    let disposeBag = DisposeBag()
    
    let contacts = [
        "603-555-1212": "Florent",
        "212-555-1212": "Junior",
        "408-555-1212": "Marin",
        "617-555-1212": "Scott"
    ]
    
    func phoneNumber(from inputs: [Int]) -> String {
        var phone = inputs.map(String.init).joined()
        
        phone.insert("-", at: phone.index(
            phone.startIndex,
            offsetBy: 3)
        )
        
        phone.insert("-", at: phone.index(
            phone.startIndex,
            offsetBy: 7)
        )
        
        return phone
    }
    
    let convert: (String) -> UInt? = { value in
        if let number = UInt(value), number < 10 {
            return number
        }
        
        let keyMap: [String: UInt] = [
            "abc": 2, "def": 3, "ghi": 4,
            "jkl": 5, "mno": 6, "pqrs": 7,
            "tuv": 8, "wxyz": 9
        ]
        
        let converted = keyMap
            .filter { $0.key.contains(value.lowercased()) }
            .map { $0.value }
            .first
        
        return converted
    }
    
    let format: ([UInt]) -> String = {
        var phone = $0.map(String.init).joined()
        
        phone.insert("-", at: phone.index(phone.startIndex, offsetBy: 3))
        phone.insert("-", at: phone.index(phone.startIndex, offsetBy: 7))
        
        return phone
    }
    
    let dial: (String) -> String = {
        if let contact = contacts[$0] {
            return "Dialing \(contact) \($0)..."
        } else {
            return "Contact not found"
        }
    }
    
    let input = PublishSubject<Int>()
    
    // Add your code here
    input.asObservable()
        .skipWhile { $0 == 0 }
        .filter { $0 >= 0 && $0 < 10 }
        .take(10)
        .toArray()
        .subscribe(onNext: { integers in
            let phone = phoneNumber(from: integers)
            if let contact = contacts[phone] {
                print("Dialing \(contact) \(phone)...")
            } else {
                print("Contact not found")
            }
        })
        .disposed(by: disposeBag)
    
    
    input.onNext(0)
    input.onNext(603)
    
    input.onNext(2)
    input.onNext(1)
    
    // Confirm that 7 results in "Contact not found", and then change to 2 and confirm that Junior is found
    input.onNext(7)
    
    "5551212".characters.forEach {
        if let number = (Int("\($0)")) {
            input.onNext(number)
        }
    }
    
    input.onNext(9)
}

/*:
 Copyright (c) 2014-2017 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
