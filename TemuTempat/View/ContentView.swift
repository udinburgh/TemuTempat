//
//  ContentView.swift
//  TemuTempat
//
//  Created by Hafizhuddin Hanif on 26/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Building.id, order: .reverse) var buildings: [Building]
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "mappin.circle")
                    Text("Map")
                }
                .task {
                    // Only check if buildings is empty - no need for UserDefaults
                    if buildings.isEmpty {
                        initializeBuildings()
                        do {
                            try context.save()
                            print("Successfully initialized \(buildings.count) buildings")
                        } catch {
                            print("Failed to save initial buildings: \(error)")
                        }
                    } else {
                        print("Found \(buildings.count) existing buildings")
                    }
                }
            ChallengeView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Challenge")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
    }
    
    private func initializeBuildings() {
        let initialBuildings = [
            Building(
                id: 1001,
                name: "GOP 1",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                isFeatured: true,
                address: "Address 1",
                tags: ["tags1", "tags2"],
                imageName: "turtlerock",
                coordinates: Building.Coordinates(latitude: -6.3018849, longitude: 106.6500193)
            ),
            Building(
                id: 1002,
                name: "GOP 9",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                isFeatured: false,
                address: "Address 2",
                tags: ["tags2", "tags3"],
                imageName: "silversalmoncreek",
                coordinates: Building.Coordinates(latitude: -6.3023062, longitude: 106.6522011)
            ),
            Building(
                id: 1003,
                name: "GOP 6",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                isFeatured: false,
                address: "Address 3",
                tags: ["tags3", "tags4"],
                imageName: "chilkoottrail",
                coordinates: Building.Coordinates(latitude: -6.3032293, longitude: 106.6531313)
            ),
            Building(
                id: 1004,
                name: "Graha Unilever",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                isFeatured: true,
                address: "Address 4",
                tags: ["tags4", "tags5"],
                imageName: "stmarylake",
                coordinates: Building.Coordinates(latitude: -6.3007555, longitude: 106.6499860)
            ),
            Building(
                id: 1005,
                name: "The Breeze",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                isFeatured: false,
                address: "Address 5",
                tags: ["tags5", "tags6"],
                imageName: "twinlake",
                coordinates: Building.Coordinates(latitude: -6.3012246, longitude: 106.6532949)
            ),
            Building(
                id: 1006,
                name: "GOP 5 Car Park",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                isFeatured: false,
                address: "Address 6",
                tags: ["tags7", "tags8"],
                imageName: "lakemcdonald",
                coordinates: Building.Coordinates(latitude: -6.3027692, longitude: 106.6509386)
            ),
            Building(
                id: 1008,
                name: "Ranch Market",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                isFeatured: false,
                address: "Address 8",
                tags: ["tags9", "tags10"],
                imageName: "icybay",
                coordinates: Building.Coordinates(latitude: -6.3022238, longitude: 106.6532611)
            ),
            Building(
                id: 1009,
                name: "Marketing Office",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                isFeatured: false,
                address: "Address 8",
                tags: ["tags10", "tags11", "tags12"],
                imageName: "rainbowlake",
                coordinates: Building.Coordinates(latitude: -6.3006173, longitude: 106.6521688)
            ),
            Building(
                id: 1010,
                name: "XXI The Breeze",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                isFeatured: false,
                address: "Address 9",
                tags: ["tags11", "tags12", "tags13"],
                imageName: "hiddenlake",
                coordinates: Building.Coordinates(latitude: -6.3027801, longitude: 106.6541153)
            ),
            Building(
                id: 1011,
                name: "Front Gate GOP",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                isFeatured: false,
                address: "Address 10",
                tags: ["tags12", "tags13", "tags14"],
                imageName: "chincoteague",
                coordinates: Building.Coordinates(latitude: -6.3001539, longitude: 106.6513491)
            ),
            Building(
                id: 2001,
                name: "Pojok Nasi Goang The Breeze",
                desc: "Memiliki lokasi tempat yang strategis karena berada di pusat kota, di sini juga menghadirkan berbagai pilihan menu khas Indonesia yang enak. Antara lain, ada nasi liwet, paket nasi goang, nasi tutug oncom, dan masih banyak lagi.",
                isFavorite: false,
                isFeatured: true,
                address: "JL. Grand Boulevard BSD Green Office Park The Breeze L-10 BSD City, Sampora, Kec. Cisauk, Kabupaten Tangerang.",
                tags: ["food", "the breeze"],
                imageName: "Pojok Nasi Goang The Breeze",
                operationalHours: "10:00 - 22:00 WIB"),
            Building(
                id: 2002,
                name: "Katsukita, The Breeze BSD",
                desc: "Menghadirkan berbagai menu khas Jepang yang enak, antara lain ada miso soup, ramen, chicken katsu, dan lain sebagainya.",
                isFavorite: false,
                isFeatured: true,
                address: "Jl. Grand Boulevard BSD Green Office Park The Breeze L-11 BSD City, Sampora, Kec. Cisauk, Kabupaten Tangerang.",
                tags: ["food", "the breeze"],
                imageName: "Katsukita, The Breeze BSD",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2003,
                name: "Bebek Bengil",
                desc: "Di sini menyajikan menu utama hidangan bebek renyah, plus sup & masakan khas Bali yang lainnya.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze BSD City Unit Waterfront L#01, Jl. Grand Boulevard, BSD Green City, Sampora.",
                tags: ["food", "the breeze"],
                imageName: "Bebek Bengil",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2004,
                name: "Wee Nam Kee",
                desc: "Restoran ini terkenal dengan menu masakan nasi hainam yang dilengkapi dengan pilihan ayam rebus atau panggang khas Singapura.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze BSD, Batik 2 - L22, Jl. BSD Green Office Park, Sampora, Tangerang.",
                tags: ["food", "the breeze"],
                imageName: "Wee Nam Kee",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2005,
                name: "Gubug Makan Mang Engking BSD",
                desc: "Menu yang tersaji di sini antara lain, ada gurame goreng sambal, tumis kangkung, udang bakar madu, ikan gurame bakar madu, dan masih banyak lagi.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze BSD City, Unit L67 A-C, Jl. Boulevard BSD Tim., Sampora, Kec. Cisauk, Kabupaten Tangerang.",
                tags: ["food", "the breeze"],
                imageName: "Gubug Makan Mang Engking BSD",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2006,
                name: "Dermaga Makassar Seafood",
                desc: "Restoran ini menyajikan berbagai pilihan menu seafood segar yang dimasak khas Makassar.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze BSD City Blok L No.68A-68B, Sampora, Cisauk, Sampora, Kec. Cisauk, Kabupaten Tangerang.",
                tags: ["food", "the breeze"],
                imageName: "Dermaga Makassar Seafood",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2007,
                name: "NOB Cafe",
                desc: "NOB Cafe menjadi pilihan yang tepat untuk pecinta pastry, khususnya Croissant. Memiliki banyak spot foto cantik dan aesthetic yang cocok untuk media sosial.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze # L-12, Bsd City, Jl. Grand Boulevard Jl. BSD Green Office Park, Sampora, Kec. Cisauk, Kabupaten Tangerang, Banten 15345",
                tags: ["food", "drink", "the breeze"],
                imageName: "NOB Cafe",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2008,
                name: "Croco by Monsieur Spoon",
                desc: "Croco merupakan sub-brand dari Monsieur Spoon yang menyajikan freshly baked Croissant, viennoiseries, dan pastry setiap harinya.",
                isFavorite: false,
                isFeatured: true,
                address: "Sampora, Kec. Cisauk, Kabupaten Tangerang, Banten",
                tags: ["food", "drink", "the breeze"],
                imageName: "Croco by Monsieur Spoon",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2009,
                name: "Luco",
                desc: "Coffee shop mungil dengan konsep outdoor, cocok bagi yang ingin bersantai jauh dari jalan raya.",
                isFavorite: false,
                isFeatured: true,
                address: "Knowledge Hub, Sampora, Cisauk, Tangerang Regency, Banten",
                tags: ["drink", "outdoor"],
                imageName: "Luco",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2010,
                name: "Paul Le Cafe",
                desc: "Paul Le Café menyajikan patisserie bergaya Perancis dan berbagai varian kopi.",
                isFavorite: false,
                isFeatured: true,
                address: "Jl. BSD Green Office Park The Breeze, Jl. BSD Grand Boulevard, Sampora, Kec. Cisauk, Kabupaten Tangerang, Banten 15345",
                tags: ["food", "drink", "the breeze"],
                imageName: "Paul Le Cafe",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 20011,
                name: "El Primero",
                desc: "Cafe dengan konsep modern minimalist yang terletak di dalam toko sepeda.",
                isFavorite: false,
                isFeatured: true,
                address: "Jl. Raya Pagedangan Kp. Cicayur II No.28, Cicalengka, Kec. Pagedangan, Kabupaten Tangerang, Banten 15336",
                tags: ["food", "drink"],
                imageName: "El Primero",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 20012,
                name: "Togu Coffee",
                desc: "Coffee shop dengan suasana homey yang cocok untuk WFC dan bersantai.",
                isFavorite: false,
                isFeatured: true,
                address: "Togu Coffee Roastery, Pagedangan, Tangerang Regency, Banten",
                tags: ["drink"],
                imageName: "Togu Coffee",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2013,
                name: "% ARABICA",
                desc: "% Arabica, salah satu merek kopi internasional terkemuka, kini membuka gerai terbarunya di Indonesia, tepatnya di BSD City The Breeze, Tangerang.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze, Bsd City, Jl. BSD Green Office Park Jl. BSD Grand Boulevard Unit L19, Sampora, Kec. Cisauk, Kabupaten Tangerang, Banten 15345",
                tags: ["drink"],
                imageName: "% ARABICA",
                operationalHours: "Weekdays: 07:00 - 22:00 WIB | Weekends: 07:00 - 23:00 WIB"
            ),
            Building(
                id: 2014,
                name: "Boost Juice Bars",
                desc: "Menyediakan jus segar dengan bahan alami.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze Blok IU-02",
                tags: ["drink", "the breeze"],
                imageName: "Boost Juice Bars",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2015,
                name: "Boots",
                desc: "Retail kesehatan dan kecantikan terkemuka dari Inggris.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze BSD City, L 63A",
                tags: ["pharmacy", "the breeze"],
                imageName: "Boots",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2016,
                name: "Brewerkz Jakarta",
                desc: "Restoran, bar, dan microbrewery franchise dari Singapura yang menyajikan berbagai jenis bir spesial dan makanan klasik Amerika.",
                isFavorite: false,
                isFeatured: true,
                address: "Pavillion 2 L. 07 & Pavillion 3 L. 08",
                tags: ["food", "drink", "the breeze"],
                imageName: "Brewerkz Jakarta",
                operationalHours: "Weekdays 11:00 - 24:00 | Weekend 11:00 - 02:00"
            ),
            Building(
                id: 2017,
                name: "Burgreens",
                desc: "Restoran plant-based yang menghadirkan hidangan sehat tanpa MSG dan bahan kimia berbahaya.",
                isFavorite: false,
                isFeatured: true,
                address: "Batik 1 L. 16",
                tags: ["food", "the breeze"],
                imageName: "Burgreens",
                operationalHours: "08:00 - 22:00 WIB"
            ),
            Building(
                id: 2018,
                name: "Chakra Hall",
                desc: "Restoran dengan konsep indoor dan outdoor yang juga digunakan untuk acara pernikahan dan event.",
                isFavorite: false,
                isFeatured: true,
                address: "Waterfront 5 L. 05",
                tags: ["food", "indoor", "outdoor", "the breeze"],
                imageName: "Chakra Hall",
                operationalHours: "11:30 - 24:00 WIB"
            ),
            Building(
                id: 2019,
                name: "Chateraise",
                desc: "Toko kue asal Jepang yang menyajikan berbagai jenis pastry dan dessert khas Jepang.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze BSD City, IU 08",
                tags: ["food", "the breeze"],
                imageName: "Chateraise",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2020,
                name: "Chatime",
                desc: "Chatime merupakan penyedia minuman brewed tea asal Taiwan yang menghadirkan lebih dari 50 varian rasa. Di Indonesia, Chatime merupakan salah satu bisnis unit di bawah payung Kawan Lama Group yang telah hadir sejak tahun 2011.",
                isFavorite: false,
                isFeatured: true,
                address: "Batik 1 L. 10A",
                tags: ["drink", "indoor"],
                imageName: "Chatime",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2021,
                name: "Chong Qing Hot Pot",
                desc: "Welcome to Chong Qing’s newest home at The Breeze BSD City, where the aroma of bubbling broths and warm smiles greet you at every turn. Retreat to our private dining areas for intimate gatherings, complete with large screens for lively karaoke sessions and polished presentations alike. Enjoy a meal steeped in authentic flavors, combining tradition and comfort in every bite.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze BSD City, L81-82",
                tags: ["food", "the breeze", "indoor"],
                imageName: "Chong Qing Hot Pot",
                operationalHours: "07:00 - 01:00 WIB"
            ),
            Building(
                id: 2022,
                name: "CinemaXX1 IMAX",
                desc: "Bioskop The Breeze XXI merupakan salah satu bioskop yang berada di bawah jaringan bioskop Cinema XXI. Berkomitmen untuk memberikan hiburan berkualitas terbaik dengan harga terjangkau, Cinema XXI siap menjadi rumah kedua untuk menikmati film dan jajanan berkualitas.",
                isFavorite: false,
                isFeatured: true,
                address: "Pavillion L. 80",
                tags: ["retail & entertainment", "the breeze", "indoor"],
                imageName: "CinemaXX1 IMAX",
                operationalHours: "11:30 - 22:00 WIB"
            ),
            Building(
                id: 2023,
                name: "Colico",
                desc: "Welcome to the tropical world of COLICO, where we serve refreshing juice made from 100% REAL fruits. COLICO is made to bring the fun back to tropical fruit juice while ensuring quality and health benefits.",
                isFavorite: false,
                isFeatured: true,
                address: "IU & Booth IU. 03",
                tags: ["drink", "indoor"],
                imageName: "Colico",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2024,
                name: "Croco by Monsieur Spoon",
                desc: "CROCO carries the \"Bakery Cafe\" concept, serving freshly baked croissants, viennoiseries, and pastries daily, paired with a variety of coffee and tea drinks, as well as Asian and European-style cuisines.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze BSD City, L 51",
                tags: ["food", "the breeze", "indoor"],
                imageName: "Croco by Monsieur Spoon",
                operationalHours: "08:00 - 22:00 WIB"
            ),
            Building(
                id: 2025,
                name: "Cut & Grill",
                desc: "If you are looking for the best steakhouse with a delightful grilling experience, come to Cut & Grill! Our steaks are made from premium fresh meat, ensuring a distinctive taste in every bite.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze BSD City, Batik 4 L. 50",
                tags: ["food", "the breeze", "indoor"],
                imageName: "Cut & Grill",
                operationalHours: "11:00 - 22:00 WIB"
            ),
            Building(
                id: 2026,
                name: "D’Cost",
                desc: "D’COST Seafood pertama didirikan tahun 2006 dengan visi menyajikan hidangan laut berkualitas dengan harga kaki lima. D’COST Seafood juga menjadi jaringan restoran hidangan laut bersertifikasi halal pertama di Indonesia.",
                isFavorite: false,
                isFeatured: true,
                address: "L-69",
                tags: ["food", "indoor"],
                imageName: "D’Cost",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2027,
                name: "Ranch Market",
                desc: "Ranch Market is a supermarket that offers high-quality and unique products, catering for high-end and middle-high customers with a focus on healthy lifestyle products such as organic and gluten-free items.",
                isFavorite: false,
                isFeatured: true,
                address: "Pavillion 5 L. 79",
                tags: ["supermarket", "indoor"],
                imageName: "Ranch Market",
                operationalHours: "08:00 - 22:00 WIB"
            ),
            Building(
                id: 2028,
                name: "Social Bread",
                desc: "Social Bread membantu bisnis untuk meningkatkan visibilitas merek secara digital melalui manajemen media sosial, live shopping, dan layanan endorsement untuk menjangkau audiens yang lebih luas.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze BSD City, Pavillion 5, L.78",
                tags: ["indoor", "the breeze"],
                imageName: "Social Bread",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2029,
                name: "Guardian",
                desc: "Guardian adalah merek ritel modern terkemuka di Asia Tenggara dalam bidang kesehatan dan kecantikan, menawarkan berbagai produk berkualitas dan layanan terbaik bagi konsumennya.",
                isFavorite: false,
                isFeatured: true,
                address: "Supermarket L. 56M",
                tags: ["pharmacy", "indoor"],
                imageName: "Guardian",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2030,
                name: "Optik Melawai",
                desc: "Optik Melawai menawarkan berbagai produk optik eksklusif dengan reputasi terpercaya, menargetkan pasar kelas menengah dan atas dengan produk berkualitas tinggi.",
                isFavorite: false,
                isFeatured: true,
                address: "Jl. BSD Grand Boulevard No.63B, Sampora, Kec. Cisauk, Kabupaten Tangerang, Banten 15345",
                tags: ["retail & entertainment", "indoor"],
                imageName: "Optik Melawai",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2031,
                name: "FictoRoring Basketball Academy",
                desc: "FictoRoring Basketball Academy adalah pusat pelatihan basket yang bertujuan untuk mengembangkan keterampilan pemain dengan fasilitas terbaik.",
                isFavorite: false,
                isFeatured: true,
                address: "Batik 5 Basket Hall",
                tags: ["sport", "indoor"],
                imageName: "FictoRoring Basketball Academy",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2032,
                name: "Gold’s Gym",
                desc: "Gold’s Gym The Breeze menawarkan pengalaman kebugaran terbaik dengan peralatan canggih, kelas GGX, dan lingkungan hijau yang menyegarkan.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze BSD City, Jalan BSD Green Office Park Jl. Boulevard Raya No.76, Unit L75",
                tags: ["sport", "the breeze", "indoor"],
                imageName: "Gold’s Gym",
                operationalHours: "06:00 - 22:00 (Senin - Jumat), 08:00 - 22:00 (Sabtu - Minggu) WIB"
            ),
            Building(
                id: 2033,
                name: "Kumulo",
                desc: "Kumulo Creative Compound adalah ruang kreatif outdoor dengan 25 toko mikro pilihan dari para artisan lokal yang menghadirkan berbagai produk F&B, fashion, dan kecantikan.",
                isFavorite: false,
                isFeatured: true,
                address: "Pavillion 5 L. 77A",
                tags: ["retail & entertainment", "outdoor", "the breeze"],
                imageName: "Kumulo",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2034,
                name: "Q Billiard",
                desc: "Q Billiard adalah pusat biliar pertama di Indonesia yang dilengkapi dengan meja Brunswick, menawarkan fasilitas berkualitas tinggi untuk penggemar biliar dari berbagai kalangan.",
                isFavorite: false,
                isFeatured: true,
                address: "Pavillion 1 L. 06",
                tags: ["retail & entertainment", "indoor"],
                imageName: "Q Billiard",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2035,
                name: "Spin City",
                desc: "Spin City Bowling Alley menghadirkan pengalaman bermain bowling terbaik dengan fasilitas mesin AMF USA terbaru, 20 jalur publik, dan 2 jalur VIP untuk pengalaman bermain yang lebih akurat dan menyenangkan.",
                isFavorite: false,
                isFeatured: true,
                address: "Supermarket L. 60",
                tags: ["retail & entertainment", "indoor"],
                imageName: "Spin City",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2036,
                name: "Wolv",
                desc: "WOLV Barbershop adalah tempat cukur rambut yang eksklusif untuk pria. Menyediakan layanan barber profesional dengan sistem booking melalui WhatsApp.",
                isFavorite: false,
                isFeatured: true,
                address: "The Breeze Lot 18A, BSD City, Kota Tangerang Selatan, Banten 15345",
                tags: ["retail & entertainment", "the breeze"],
                imageName: "Wolv",
                operationalHours: "10:00 - 22:00 WIB"
            )
        ]
        
        // Insert all buildings into the context
        initialBuildings.forEach { building in
            context.insert(building)
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Building.self, inMemory: true)
}
