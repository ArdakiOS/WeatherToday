
import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var pass = ""
    @State private var err = false
    @State private var loading = false
    @Binding var isLoggedIn: Bool
    var body: some View {
        NavigationView(){
            ZStack{
                if loading == true{
                    LoadingView()
                }
                else{
                    VStack(spacing: 20){
                        Group{
                            Spacer(minLength: 200)
                            Text("Login")
                                .fontWeight(.bold)
                                .font(.title)
                                .offset(x: -120, y:-40)
                            TextField("", text: $email)
                                .textFieldStyle(.plain)
                                .foregroundColor(.white)
                                .placeholder(when: email.isEmpty) {
                                    Text("Email")
                                        .bold()
                                }
                                .offset(x: 20)
                            
                            Rectangle()
                                .frame(height: 1)
                            
                            SecureField("", text: $pass)
                                .textFieldStyle(.plain)
                                .foregroundColor(.white)
                                .placeholder(when: pass.isEmpty) {
                                    Text("Password")
                                        .bold()
                                }
                                .offset(x: 20)
                            
                            Rectangle()
                                .frame(height: 1)
                        }
                        
                        Spacer()
                        
                        Button {
                            loading = true
                            login()
                            
                        } label: {
                            Text("Login")
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                    
                                )
                        }.padding(.top)
                        
                        NavigationLink {
                            AuthView(isLoggedIn: $isLoggedIn)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("New user? Create account")
                                .foregroundColor(.white)
                        }
                        Spacer()
                        
                    }
                    .alert("Incorrect email or password", isPresented: $err, actions: {
                        Button("Ok", role: .cancel){}
                    })
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
            }
            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
        }
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: pass){ result, error in
            if error != nil {
                err = true
                loading = false
            }
            else{
                isLoggedIn = true
                loading = false
            }
            
        }
    }
    
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
