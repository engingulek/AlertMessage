import SwiftUI
import Combine




public struct AlertMessage : View {
    var text : String
    var desc : String
    var alertIcon : AlertIcon
    var backroundColor : Color

    
   
    public init(text:String,
                desc:String,
                alertIcon:AlertIcon = .multiplyCircle,
                backroundColor : Color = .red
                
    ){
        self.text = text
        self.desc = desc
        self.alertIcon = alertIcon
        self.backroundColor = backroundColor
       
    }
    
    
    
    public var body: some View {
        VStack(alignment:.center,spacing: 10) {
            alertIcon.icon
                .font(.system(size: 50))
            Text(text)
                .font(.title)
                .fontWeight(.bold)
            Text(desc)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .lineLimit(4)
                
          
            
            
        }
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width / 2, height: 180)
        .padding()
        .background(backroundColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(backroundColor, lineWidth: 2)
        )
        
    }
    
}


@available(iOS 13, macOS 11, *)
public struct AlertMessageMofier : ViewModifier {
    
    
    @Binding var isPresenting : Bool
    var duration : Double =  2
    var alertMessage :() -> AlertMessage
   
 
    @ViewBuilder
    public func main() -> some View {
        if isPresenting  { VStack{
                alertMessage()
                    .onTapGesture {
                            withAnimation(Animation.spring()){
                                isPresenting = false
                            }
                        
                    } .transition(AnyTransition.scale(scale: 0.8).combined(with: .opacity))
        }
            
        }
    }
    
    @ViewBuilder
    public func body(content: Content) -> some View {
        content
            .overlay {
                ZStack{
                  main()
                      
                }.edgesIgnoringSafeArea(.all)
                    .animation(Animation.spring(), value: isPresenting)
                    .valueChanged(value: isPresenting) { presented in
                        if presented{
                            onAppearAction()
                        }
                    }
            }
        
      
            
    }
    private func onAppearAction() {
           let task = DispatchWorkItem {
            withAnimation(Animation.spring()){
                isPresenting = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: task)
    }
    
    
}

public extension View {
    func message( isPresenting:Binding<Bool>,alertMessage:@escaping () -> AlertMessage) -> some View {
        modifier(AlertMessageMofier(isPresenting: isPresenting, alertMessage:alertMessage))
    }
}

struct  AlertMessage_Previews : PreviewProvider {
    static var previews: some View {
        AlertMessage(text: "Danger",desc: "Lorem Ipsum is simply dummy text of the printing and typesetting industry")
            .environment(\.colorScheme, .light)
                      // .previewLayout(.sizeThatFits)
                      // .padding(10)
    }
}

public extension View {
    @ViewBuilder fileprivate func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
           if #available(iOS 14.0, *) {
               self.onChange(of: value, perform: onChange)
           } else {
               self.onReceive(Just(value)) { (value) in
                   onChange(value)
               }
           }
       }
}
