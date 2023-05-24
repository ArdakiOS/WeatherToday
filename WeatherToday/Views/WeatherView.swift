
import SwiftUI

struct WeatherView: View {

    @State var weather: ResponseBody

    @State var city = ""
    var weatherManager = WeatherManager()
    var body: some View {
        
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    TextField("", text: $city)
                        .textFieldStyle(.plain)
                        .placeholder(when: city.isEmpty) {
                            Text("Search city...")
                                .bold()
                        }
                        .overlay (
                            Button(action: {
                                Task {
                                    weather = try await weatherManager.getCityWeather(cityName: city)
                                }
                                
                            }, label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white)
                                    .padding(.trailing)
                            })
                           
                            ,alignment: .trailing
                        )
                        
                        
                        
                    Rectangle()
                        .frame(width: .infinity, height: 1)
                        .padding(.bottom)
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            switch weather.weather[0].id {
                            case 200...232:
                                Image(systemName: "cloud.bolt")
                                    .font(.system(size: 40))
                            case 300...321:
                                Image(systemName: "cloud.drizzle")
                                    .font(.system(size: 40))
                            case 500...531:
                                Image(systemName: "cloud.rain")
                                    .font(.system(size: 40))
                            case 600...622:
                                Image(systemName: "cloud.snow")
                                    .font(.system(size: 40))
                            case 701...781:
                                Image(systemName: "cloud.fog")
                                    .font(.system(size: 40))
                            case 800:
                                Image(systemName: "sun.max")
                                    .font(.system(size: 40))
                            case 801...804:
                                Image(systemName: "cloud")
                                    .font(.system(size: 40))
                            default:
                                Image(systemName: "cloud.fill")
                                    .font(.system(size: 40))
                            }
                            
                            Text(weather.weather[0].main)
                                .font(.title)
                                .bold()
                                .foregroundColor(.purple)
                            
                            switch weather.weather[0].id {
                            case 200...232:
                                Text("Be careful! You should take a cab")
                            case 300...321:
                                Text("It is drizzling outside! Be cautious")
                            case 500...531:
                                Text("It is raining outside. Take an umbrella")
                            case 600...622:
                                Text("It is snowing outside. Wear a warm clothing")
                            case 701...781:
                                Text("There is fog outside. You should be careful")
                            case 800:
                                Text("So sunny, put your sunscreen! Have a nice day")
                            case 801...804:
                                Text("Be careful! You should take a cab")
                            default:
                                Text("Cloudy! It is ok")
                            }
                            
                        }
                        .padding(.top)
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.temp.roundDouble() + "°")
                            .font(.system(size: 70))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height:  80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Details")
                        .bold()
                        .padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
