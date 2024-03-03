//
//  MangaDetailView.swift
//  Swiftyomi
//
//  Created by renyi on 2024/2/12.
//

import SwiftUI

struct MangaDetailView: View {
    let manga: Manga
    var filterMethods = ["正序", "逆序"]
    @Environment(\.openURL) var openURL
    @State private var isExpanded: Bool = false
    @State private var selectedFilterMethod = "正序"
    @ObservedObject var mdViewModel = MangaDetailViewModel()
    @ObservedObject var cdViewModel = ChapterDetailViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                // Image
                HStack(alignment: .center, spacing: 20) {
                    MangaCoverCellView(manga: manga)
                        .clipShape(.rect(cornerRadius: 12))
                        .frame(width: 100, height: 180)
                        .frame(maxWidth: 100, maxHeight: 200)
                        .padding(.leading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(manga.title)
                            .font(.title)
                            .bold()
                            .lineLimit(2) // 设置最大行数为2行
                            .minimumScaleFactor(0.5) // 设置最小缩放比例为0.5
                        Text("Author: \(manga.author ?? "Unknown")")
                        Text("Artist: \((manga.artist ?? "Unknown"))")
                        Text("Status: \(manga.status.lowercased())")
                        Text("Source: \(manga.source ?? "Unknown")")
                        Text("Unread: \(manga.unreadCount ?? 0)")
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding(.horizontal)
                
                // Info
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(manga.genre ?? [""], id: \.self) { item in
                                Text(item)
                                    .padding(8)
                                    .background(.bar, in: .rect(cornerRadius: 8))
                            }
                        }
                    }
                    Text(manga.description ?? "")
                        .lineLimit(isExpanded ? nil : 3)
                        .truncationMode(.tail)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isExpanded.toggle()
                            }
                        }
                        .foregroundColor(.secondary)
                        .padding(.bottom)
                    
                }
                .padding(.horizontal)
                
                // Tag
                HStack {
                    Button {
                        if !manga.inLibrary {
                                        addToLibrary(mangaId: manga.id)
                        } else {
                                        deleteFromLibrary(mangaId: manga.id)
                        }
                    } label: {
                        Label("BookMark", systemImage: manga.inLibrary ? "bookmark.fill" : "bookmark")
                            .frame(maxWidth: .infinity)
                            .labelStyle(.iconOnly)
                    }
                    .padding()
                    .background(.bar)
                    .cornerRadius(12)
                    
                    Button {
                        openURL(URL(string: manga.realUrl ?? "")!)
                    } label: {
                        Label("Open", systemImage: "safari")
                            .frame(maxWidth: .infinity)
                            .labelStyle(.iconOnly)
                    }
                    .padding()
                    .background(.bar)
                    .cornerRadius(12)
                    
                    Button{
                        
                    } label: {
                        Label("Read", systemImage: "book")
                            .frame(maxWidth: .infinity)
                            .labelStyle(.iconOnly)
                    }
                    .padding()
                    .background(.bar)
                    .cornerRadius(12)
                }
                .bold()
                .padding(.horizontal)
                
                HStack {
                    Text("Total \(String(describing: mdViewModel.mangaChapterList.count)) Chapters")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Group {
                        Button {
                            
                        } label: {
                            Label("mutil Select", systemImage: "square")
                        }
                        Button {
                            
                        } label: {
                            Label("Download Selected Chapter", systemImage: "arrow.down.to.line")
                        }
                        Button {
                            
                        } label: {
                            Label("", systemImage: "line.3.horizontal.decrease")
                        }
                    }
                    .labelStyle(.iconOnly)
                }
                .padding()
                
                Divider()
                
                LazyVStack {
                    if mdViewModel.isLoading {
                        ProgressView()
                    } else {
                        ForEach(mdViewModel.mangaChapterList, id: \.id) { chapter in
                            HStack {
                                NavigationLink(destination: {
                                    ChapterDetailView(chapter: chapter, viewModel: cdViewModel)
                                }, label: {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("\(chapter.name)")
                                                .font(.title3)
                                            Text("\(formatUnixTimestamp(chapter.fetchedAt))")
                                                .font(.callout)
                                        }
                                        Spacer()
                                    }
                                })
                            }
                            .tag(chapter)
                            .padding(.vertical, 4)
                            #if os(iOS)
                            .foregroundStyle(Color(uiColor: .label))
                            #endif
                            Divider()
                        }
                    }
                }
                .padding(.horizontal)
                .refreshable {
                    mdViewModel.fetchMangaChapters(mangaId: manga.id)
                }
            }
        }
        .onAppear {
            mdViewModel.fetchMangaChapters(mangaId: manga.id)
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        MangaDetailView(manga: sampleManga)
    }
}

func formatUnixTimestamp(_ unixTimestamp: Int, dateFormat: String = "yyyy/MM/dd") -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    dateFormatter.timeZone = TimeZone.current
    
    return dateFormatter.string(from: date)
}
