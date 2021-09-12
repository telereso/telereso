//
//  ContentView.swift
//  Lists
//
//  Created by Aarish Rahman on 07/08/21.
//

import SwiftUI
import CoreData
import UIKit
import Telereso

struct StoryBoardView: View {
    var body: some View {
        MainStoryBoardView()
    }
}

struct CustomGroup:View {
    var img = ""
    var count = ""
    var col:Color
    var label = ""
    var body: some View{
        VStack{
            GroupBox(label:
                        HStack{
                            Text("\(Image(systemName: img))")
                                .foregroundColor(col)
                                .font(.title)
                            Spacer()
                            Text(count)
                                .foregroundColor(.gray)
                                .font(.title)
                                .fontWeight(.bold)
                        }
            ){
                VStack{
                    Text("")
                    HStack{
                        Text(label)
                            .font(.title2)
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
            }.cornerRadius(15)
                
            
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Manga.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Manga.name, ascending: true),
        NSSortDescriptor(keyPath: \Manga.chapters, ascending: true)
    ]) var manga: FetchedResults<Manga>
    @FetchRequest(entity: Movie.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Movie.name, ascending: true),
        NSSortDescriptor(keyPath: \Movie.rating, ascending: true)
    ]) var movie: FetchedResults<Movie>
    @FetchRequest(entity: TvShow.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \TvShow.name, ascending: true),
        NSSortDescriptor(keyPath: \TvShow.episode, ascending: true)
    ]) var show: FetchedResults<TvShow>
    @FetchRequest(entity: Anime.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Anime.name, ascending: true),
        NSSortDescriptor(keyPath: \Anime.episode, ascending: true)
    ]) var anime: FetchedResults<Anime>

    @State private var result: Result<Bool, Error>?
    
    func initTelereso(){
        Telereso.enableRealTimeChanges().enableStringLog().initialize(){() -> Void in
            result = Result.success(true)
        }
    }
    
    var body: some View {
        switch result {
        case .success(_):
            mainBody
        case .failure(let error):
            let _ = print(error)
            mainBody
        case nil:
            // We display a classic loading spinner while we're
            // waiting for our content to load, and we start our
            // loading operation once that view appears:
            ProgressView().onAppear(perform: initTelereso)
        }
        
    }
    
    var mainBody: some View{
        NavigationView{
            ScrollView{
            VStack{
               
                LazyVGrid(columns: [.init(), .init()]) {
                    NavigationLink(destination: MangaList()){
                        CustomGroup(img: "books.vertical", count: "\(manga.count)", col: Color.green, label:Telereso.getRemoteString("Manga"))
                    }
                    NavigationLink(destination: AnimeList()){
                        CustomGroup(img: "tv", count: "\(anime.count)", col: Color.red, label: "Anime")
                    }
                    NavigationLink(destination: ShowList()){
                        CustomGroup(img: "play.tv", count: "\(show.count)", col: Color.orange, label: "Tv Shows")
                    }
                    NavigationLink(destination: MovieList()){
                        CustomGroup(img: "film", count: "\(movie.count)", col: Color.blue, label: "Movies")
                    }
                    
                }.padding()
                
                Form{
                    HStack{
                        NavigationLink(destination: Recents()){
                        Label(
                            title: { Text("Recently added")
                                .font(.title2)
                            },
                            icon: { Image(systemName: "list.bullet")
                                .padding(9)
                                .font(.title2)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                            }
                        )
                        }
                        
                    }.padding(5)
                }.frame(height: 125)
                
                VStack{
                LazyVGrid(columns: [.init(), .init()]) {
                    NavigationLink(destination: TopMangaList()){
                        CustomGroup(img: "book", col: Color.green, label: "Top Manga")
                    }
                    NavigationLink(destination: TopAnimeList()){
                        CustomGroup(img: "play",  col: Color.yellow, label: "Top anime")
                    }
                }.padding()
                }
                
                VStack{
                LazyVGrid(columns: [.init()]) {
                  NavigationLink(destination: StoryBoardView()){
                        CustomGroup(img: "play",  col: Color.yellow, label: "Storyboard")
                    }
                }.padding()
                }
            }
               
            .navigationTitle("Lists")
            }
            
            
        }
    }
  
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
