//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//example(of: "PublishSubject") {
//    let subject = PublishSubject<String>()
//
//    let subscription1 = subject
//        .subscribe(onNext: { string in
//            print(string)
//        })
//
//    subject.on(.next("1"))
//    subject.on(.next("2"))
//
//    let subscription2 = subject
//        .subscribe { event in
//            print("2)", event.element ?? event)
//        }
//
//    subject.onNext("3")
//
//    subscription1.dispose()
//
//    subject.onNext("4")
//
//    subject.onCompleted()
//
//    subject.onNext("5")
//
//    subscription2.dispose()
//
//    let disposeBag = DisposeBag()
//
//    subject.subscribe {
//        print("3)", $0.element ?? $0)
//    }.disposed(by: disposeBag)
//}

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event ?? "NULL")
}

example(of: "BehaviorSubject") {
    let subject = BehaviorSubject(value: "Initial value")
    subject.onNext("X")

    let disposeBag = DisposeBag()
    
    subject.subscribe {
        print(label: "1)", event: $0)
    }.disposed(by: disposeBag)
    
    subject.onError(MyError.anError)
    
    subject.subscribe {
        print(label: "2)", event: $0)
    }.disposed(by: disposeBag)
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
