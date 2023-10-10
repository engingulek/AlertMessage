# AlertMessage



https://github.com/engingulek/AlertMessage/assets/74055938/785734d1-3ccc-4dc1-8b08-d7582d6c174e



## Installation

### [Swift Package Manager](https://github.com/engingulek/AlertMessage.git)

```swift
dependencies: [
    .package(url: "https://github.com/exyte/PopupView.git")
]

:branch="main"
```

## Requirements

Only iOS 15.0+

## Usage

It turns off two seconds after opening

```swift
import SwiftUI
import AlertMessage
struct ContentView: View {
    @State var showAlert : Bool = false
    var body: some View {
        VStack {
            Button("Alert Message") {
                showAlert = true
            }
        }
        .message(isPresenting: $showAlert) {
            AlertMessage(text: "Error", desc: "Lorem Ipsum is simply dummy text of the printing and typesetting ")
            //AlertMessage(text: "Error", desc: "Lorem Ipsum is simply dummy text of the printing and typesetting ",alertIcon: .multiplyCircle)
            
           // AlertMessage(text: "Error", desc: "Lorem Ipsum is simply dummy text of the printing and typesetting ",backroundColor: .red)
        }
     
    }
}
```

