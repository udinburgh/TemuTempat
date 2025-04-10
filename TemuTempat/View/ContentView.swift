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
        .ignoresSafeArea(.keyboard)
    }
    
    private func initializeBuildings() {
        let initialBuildings = [
            Building(
                id: 3,
                name: "Green Office Park 1",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                address: "Address 1",
                tags: ["GOP 1"],
                imageName: "travelokacampus",
                coordinates: Building.Coordinates(latitude: -6.3018849, longitude: 106.6500193)
            ),
            Building(
                id: 1,
                name: "Green Office Park 9",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                address: "Address 2",
                tags: ["GOP 9"],
                imageName: "gop9",
                coordinates: Building.Coordinates(latitude: -6.3023062, longitude: 106.6522011)
            ),
            Building(
                id: 4,
                name: "Green Office Park 6",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                address: "Address 3",
                tags: ["GOP 6"],
                imageName: "myrepublicplaza",
                coordinates: Building.Coordinates(latitude: -6.3032293, longitude: 106.6531313)
            ),
            Building(
                id: 8,
                name: "Graha Unilever",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                address: "Address 4",
                tags: ["graha unilever"],
                imageName: "grahaunilever",
                coordinates: Building.Coordinates(latitude: -6.3007555, longitude: 106.6499860)
            ),
            Building(
                id: 2,
                name: "The Breeze",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                address: "Address 5",
                tags: ["The Breeze"],
                imageName: "thebreeze",
                coordinates: Building.Coordinates(latitude: -6.3012246, longitude: 106.6532949)
            ),
            Building(
                id: 6,
                name: "GOP 5 Car Park",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                address: "Address 6",
                tags: ["GOP 5"],
                imageName: "lakemcdonald",
                coordinates: Building.Coordinates(latitude: -6.3027692, longitude: 106.6509386)
            ),
            Building(
                id: 7101, // Other, Marketing Office, 01
                name: "Marketing Office",
                desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
                isFavorite: false,
                address: "Address 8",
                tags: ["marketing office"],
                imageName: "rainbowlake",
                coordinates: Building.Coordinates(latitude: -6.3006173, longitude: 106.6521688)
            ),
            Building(
                id: 2401, // Food, GOP 6, 01
                name: "Lawson",
                desc: "Lawson, Inc. is a Japanese convenience store franchise chain. Lawson offers a wide variety of snacks and drinks to choose from. It’s well-known for its oden, choux, tteokbokki, and onigiri. A while back, their snack tray combo—a mix of drinks and light bites—went pretty viral too. Lawson also has some cool deals to help you shop smarter; check out their official social media for more details.",
                isFavorite: false,
                address: "Lt. B1 Gedung GOP 6",
                tags: ["food", "drink", "GOP 6"],
                imageName: "lawson",
                operationalHours: "08:00 - 20:30 WIB"
            ),
            Building(
                id: 2402, // Food, GOP 6, 02
                name: "Kantin GOP 6",
                desc: "The GOP 6 Canteen, located in the basement of Green Office Park 6 (now known as MyRepublic Plaza) in BSD City, is a cozy and affordable dining spot for employees and visitors. It offers a variety of tasty options, from classic Indonesian dishes to light snacks, with prices that suit different budgets.",
                isFavorite: false,
                address: "Lt. B1 Gedung GOP 6",
                tags: ["food", "drink", "GOP 6"],
                imageName: "kantingop6",
                operationalHours: nil
            ),
            Building(
                id: 5401, // Toilet, GOP 6, 01
                name: "Toilet GOP 6",
                desc: "Place for sanitation-related activities, the toilet here is, of course, clean and fresh-smelling.",
                isFavorite: false,
                address: "Lt. B1 Gedung GOP 6",
                tags: ["toilet", "GOP 6"],
                imageName: "toilet",
                operationalHours: nil
            ),
            Building(
                id: 6401, // Mushola, GOP 6, 01
                name: "Mushola GOP 6",
                desc: "A place for praying activities for Muslim men and women.",
                isFavorite: false,
                address: "Lt. B1 Gedung GOP 6",
                tags: ["mushola", "GOP 6"],
                imageName: "mushola",
                operationalHours: nil
            ),
//            Building(
//                id: 9401, // ATM, GOP 6, 01
//                name: "ATM Bank Mandiri",
//                desc: "ATM Bank Mandiri tersedia untuk melakukan transaksi seperti transfer, tarik dan setor tunai.",
//                isFavorite: false,
//                address: "Lt. B1 Gedung GOP 6",
//                tags: ["atm", "GOP 6"],
//                imageName: "mandiriatm",
//                operationalHours: nil
//            ),
            Building(
                id: 2201, // Food, GOP 9, 01
                name: "Kantin GOP 9 (Green Eatery)",
                desc: "The GOP 9 Canteen, better known as Green Eatery, is located in the basement of Green Office Park 9 in BSD City, offering a comfy and affordable dining spot for employees and visitors. It serves up a variety of tasty dishes, from Indonesian favorites like nasi campur and soto to light snacks and refreshing drinks, all in a clean and practical setting. The go-to eatery for GOP 9 folks is Dapur Kasturi, which also offers convenient pick-up service through WhatsApp.",
                isFavorite: false,
                address: "Lt. B Gedung GOP 9",
                tags: ["food", "drink", "GOP 9"],
                imageName: "greeneatery",
                operationalHours: nil
            ),
            Building(
                id: 2202, // Food, GOP 9, 02
                name: "Alfamart Express",
                desc: "Alfamart Express is an Indonesian convenience store franchise chain under the Alfamart network. It stocks typical Indonesian convenience store items like snacks, soft drinks, fried chicken, bread, and other daily essentials. Recommended picks at Alfamart Express include Bean Spot coffee, ready-to-eat meals, and handy local snacks. They also roll out cool promos like special discounts or budget-friendly combo deals, making shopping there even more wallet-friendly.",
                isFavorite: false,
                address: "Lt. B1 Gedung GOP 9",
                tags: ["food", "drink", "GOP 9"],
                imageName: "alfamart",
                operationalHours: nil
            ),
            Building(
                id: 5201, // Toilet, GOP 9, 01
                name: "Toilet Basement GOP 9",
                desc: "Place for sanitation-related activities, the toilet here is, of course, clean and fresh-smelling. Shower room available.",
                isFavorite: false,
                address: "Lt. B1 Gedung GOP 9",
                tags: ["toilet", "GOP 9"],
                imageName: "toilet",
                operationalHours: nil
            ),
            Building(
                id: 6201, // Mushola, GOP 9, 01
                name: "Mushola GOP 9",
                desc: "A place of worship for Muslim men and women, featuring two mushola locations, both conveniently close to Green Eatery.",
                isFavorite: false,
                address: "Lt. B1 Gedung GOP 9",
                tags: ["mushola", "GOP 9"],
                imageName: "mushola",
                operationalHours: nil
            ),
            Building(
                id: 2101, // Drink, The Breeze, 01
                name: "% Arabica",
                desc: "% Arabica is about my love for coffee, design, and seeing the world.",
                isFavorite: false,
                address: "The Breeze",
                tags: ["drink", "The Breeze"],
                imageName: "persenarabica",
                operationalHours: nil
            ),
            Building(
                id: 2102, // Food, The Breeze, 02
                name: "SALADSTOP!",
                desc: "The First and Largest Healthy Food Chain Restaurant in Asia. Pioneer of the healthy eating movement, our core values are integrity, respect, and commit to excellence - reflected in every step of our process whether it is how we work with our farm partners, the new locally inspired dressing of the season, or the way our team is considered family. EAT - WIDE - AWAKE",
                isFavorite: false,
                address: "The Breeze",
                tags: ["food", "The Breeze"],
                imageName: "saladstop",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 8103, // Retail, The Breeze, 03
                name: "WOLV",
                desc: "WOLV Barbershop adalah tempat cukur rambut yang eksklusif untuk pria. Menyediakan layanan barber profesional dengan sistem booking melalui WhatsApp.",
                isFavorite: false,
                address: "The Breeze",
                tags: ["retail", "The Breeze"],
                imageName: "wolv",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2104, // Food, The Breeze, 04
                name: "N.O.B Cafe @ Pattiserie",
                desc: "NOB Cafe menjadi pilihan yang tepat untuk pecinta pastry, khususnya Croissant. Memiliki banyak spot foto cantik dan aesthetic yang cocok untuk media sosial.",
                isFavorite: false,
                address: "The Breeze",
                tags: ["food", "drink", "The Breeze"],
                imageName: "nobcafe",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2105, // Food, The Breeze, 05
                name: "Burgreens Eatery & Market",
                desc: "Burgreens is a manifestation of a conscious eating movement that believes that what we eat directly impacts our health, animal & farmers’ welfare, and environmental sustainability. Since the very beginning, our mission is to make healthy, ethical, and sustainable food as delicious, fun, convenient, and accessible as junk food - while empowering local farmers and women through a responsible supply chain!",
                isFavorite: false,
                address: "The Breeze",
                tags: ["food", "The Breeze"],
                imageName: "burgreens",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2106, // Drink, The Breeze, 06
                name: "TAMPER",
                desc: "The primary goal with tamping coffee is to compact the bed of coffee and create a flat and even surface, for the pressurised water to flow through, evenly extracting flavour. The way you stand, the way you hold the portafilter and the tamper, will all affect the quality of your tamp.",
                isFavorite: false,
                address: "The Breeze, Bsd City, Blok IU 11",
                tags: ["drink" ,"The Breeze"],
                imageName: "tamper",
                operationalHours: "07:00 - 22:00 WIB"
            ),
            Building(
                id: 2501, // Food, The Breeze, 01
                name: "HONU",
                desc: "Honu's menu is a modern take on the classic Hawaiian dish and traditional Japanese tea to create an accessible and wholesome dining ritual.",
                isFavorite: false,
                address: "The Breeze BSD (L-25)",
                tags: ["food", "The Breeze"],
                imageName: "honu",
                operationalHours: "10:00 - 22:00 WIB"
            ),
//            Building(
//                id: 2502, // Food, The Breeze, 02
//                name: "The Pancake Co. by DORE",
//                desc: "A modern Japanese café specializing in the fluffiest soufflé pancakes for you to indulge with your family and friends!",
//                isFavorite: false,
//                address: "The Breeze BSD City - Unit L.23.",
//                tags: ["food", "The Breeze"],
//                imageName: "thepancakeco",
//                operationalHours: "10:00 - 22:00 WIB"
//            ),
            Building(
                id: 2502, // Food, The Breeze, 02
                name: "The Pancake Co. by DORE",
                desc: "A modern Japanese café specializing in the fluffiest soufflé pancakes for you to indulge with your family and friends!",
                isFavorite: false,
                address: "The Breeze BSD City - Unit L.23.",
                tags: ["food", "The Breeze"],
                imageName: "thepancakeco",
                operationalHours: "10:00 - 22:00 WIB"
            ),
//            Building(
//                id: 2503, // Food, The Breeze, 03
//                name: "Sate Khas Senayan",
//                desc: "Sate Khas Senayan is a restaurant chain that blends traditional Indonesian recipes with research and innovation to deliver consistently delicious and authentic flavors. Established in 1974 as Sate House Senayan, it has grown while staying true to its mission of promoting Indonesia’s rich culinary heritage. The brand emphasizes adapting timeless dishes to modern tastes using advanced cooking techniques and a warm, attentive service style, creating a dining experience that’s both innovative and distinctly Indonesian. With a focus on quality and hospitality, it remains relevant across generations, offering a welcoming atmosphere where guests can enjoy unique local cuisine.",
//                isFavorite: false,
//                address: "The Breeze, Batik 3 L. 33-35.",
//                tags: ["food", "The Breeze"],
//                imageName: "satekhasenayan",
//                operationalHours: "10:00 - 22:00 WIB"
//            ),
            Building(
                id: 2504, // Drink, The Breeze, 04
                name: "Fore",
                desc: "Established in 2018, Fore Coffee is a passionate coffee startup aiming to brew the best specialty coffee for our customers. As our name derived from the word forest, we aim to grow fast, strong, tall and bring life to our surroundings. We want our existence to increase coffee quality for our community. Leveraging network and experience, we are using the latest tech for our tools and bean blend. Directly from the selected farmer, high-quality beans are processed and roasted to perfection by ourselves then passed on to our skilled barista, excitedly preparing the cup of happiness to be served to you especially.",
                isFavorite: false,
                address: "The Breeze, IU & Booth IU. 05",
                tags: ["drink", "The Breeze"],
                imageName: "fore",
                operationalHours: "08:00 - 22:00 WIB"
            ),
            Building(
                id: 2505, // Food, The Breeze, 05
                name: "Hachi Grill",
                desc: "Hachi Grill The Breeze is the ultimate place to delight the quality of meat and fresh hydroponic vegetables at the best price, with special signature choice of soups and sauce to elevate the next level taste of yakiniku and shabu-shabu. We provide dedicated smokeless roaster and personal induction stove for you to enjoy your own space and your favorite way to cook. Please rejoice in our various delicious side dishes and customize your own dessert in the simple minimalist appearance and industrial atmosphere. We cherish to spend your relaxing and joyful moment with cozy space at Hachi Grill The Breeze.",
                isFavorite: false,
                address: "The Breeze, Unit L27",
                tags: ["food", "The Breeze"],
                imageName: "hachigrill",
                operationalHours: "11:00 - 21:00 WIB"
            ),
            Building(
                id: 2506, // Entertainment, The Breeze, 06
                name: "XXI",
                desc: "Cinema The Breeze XXI is one of the cinemas under the Cinema XXI network. Committed to providing the best quality entertainment at affordable prices, Cinema XXI is ready to become a second home for enjoying quality movies and snacks.",
                isFavorite: false,
                address: "The Breeze, Pavillion L. 80",
                tags: ["entertainment", "The Breeze"],
                imageName: "xxi",
                operationalHours: "11:30 - 22:00 WIB"
            ),
            Building(
                id: 2507, // Food, The Breeze, 07
                name: "Paul Le Cafe",
                desc: "Paul Le Café serves French-style patisserie and a variety of coffee options.",
                isFavorite: false,
                address: "The Breeze",
                tags: ["food", "The Breeze"],
                imageName: "paullecafe",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2508, // Shopping, The Breeze, 08
                name: "Guardian",
                desc: "Guardian is a leading modern retail brand in Southeast Asia in health and beauty, offering a wide range of quality products and the best services for its customers.",
                isFavorite: false,
                address: "The Breeze L. 56M",
                tags: ["pharmacy", "The Breeze", "outdoor"],
                imageName: "guardian",
                operationalHours: "10:00 - 22:00 WIB"
            ),
//            Building(
//                id: 2510, // Beverages, The Breeze, 10
//                name: "Wine & Spirit Co.",
//                desc: "Wines are made with grape juice, which contains natural sugars that can affect the taste. Spirits, on the other hand, are made with distilled alcohols, which tend to be much drier.",
//                isFavorite: false,
//                address: "The Breeze, Supermarket L. 62.",
//                tags: ["beverages", "The Breeze"],
//                imageName: "wineandspiritco",
//                operationalHours: "10:00 - 22:00 WIB"
//            ),
//            Building(
//                id: 2511, // Food, The Breeze, 11
//                name: "Gallura",
//                desc: "Gallura is a delightful Italian restaurant located at The Breeze BSD, offering an authentic taste of Italy in a cozy and inviting atmosphere.",
//                isFavorite: false,
//                address: "The Breeze Unit L 60",
//                tags: ["food", "The Breeze"],
//                imageName: "gallura",
//                operationalHours: "10:00 - 22:00 WIB"
//            ),
            Building(
                id: 2509, // Food, The Breeze, 09
                name: "Leko",
                desc: "Warung Leko BSD is a restaurant specializing in 'Iga Penyet' (smashed beef ribs) located in BSD. Beverage prices start from around IDR 50,000 and food prices start from around IDR 15,000.",
                isFavorite: false,
                address: "The Breeze, Ground Floor",
                tags: ["food", "The Breeze"],
                imageName: "leko",
                operationalHours: "11:00 - 21:30 WIB"
            ),
            Building(
                id: 2510, // Food, The Breeze, 10
                name: "Ikkudo Ichi",
                desc: "Ikkudo Ichi serves authentic Japanese ramen that has been adapted to Indonesian tastes since 2012.",
                isFavorite: false,
                address: "The Breeze, Ground Floor",
                tags: ["food", "The Breeze", "ramen"],
                imageName: "ikkudoichi",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2511, // Entertainment, The Breeze, 11
                name: "Q Billiard",
                desc: "Q Billiard is the first and only billiard center in Indonesia equipped with Brunswick tables, aimed at providing Grade A facilities.",
                isFavorite: false,
                address: "The Breeze, No. Kav 07",
                tags: ["entertainment", "The Breeze", "billiard"],
                imageName: "qbilliard",
                operationalHours: "11:00 - 22:00 WIB"
            ),
            Building(
                id: 2512, // Coffee, The Breeze, 12
                name: "Toby’s Estate",
                desc: "Toby’s Estate at The Breeze BSD is a cozy hangout spot serving specialty coffee, brunch, and an all-day dining menu.",
                isFavorite: false,
                address: "The Breeze, West Lobby",
                tags: ["coffee", "The Breeze", "brunch"],
                imageName: "tobysestate",
                operationalHours: "07:00 - 22:00 WIB"
            ),
            Building(
                id: 2513, // Food, The Breeze, 13
                name: "Katsukita",
                desc: "Katsukita offers a variety of delicious Japanese dishes including miso soup, ramen, chicken katsu, and more.",
                isFavorite: false,
                address: "The Breeze, Ground Floor L-11",
                tags: ["food", "The Breeze", "Japanese"],
                imageName: "katsukita",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2514, // Food, The Breeze, 14
                name: "HanGuksu Seoul In A Bowl",
                desc: "HanGuksu is a Korean restaurant chain that specializes in noodle dishes. The name combines the Korean words 'hanguk' (Korea) and 'guksu' (noodles).",
                isFavorite: false,
                address: "The Breeze BSD City, L12",
                tags: ["food", "The Breeze", "Korean"],
                imageName: "hanguksu",
                operationalHours: "10:00 - 21:30 WIB"
            ),
            Building(
                id: 2515, // Food, The Breeze, 15
                name: "The People’s Cafe",
                desc: "The People’s Cafe in BSD, South Tangerang is a cafe that offers a variety of street foods from around the world. It's a great spot to hang out with friends or spend quality time with family.",
                isFavorite: false,
                address: "The Breeze, L15",
                tags: ["cafe", "The Breeze"],
                imageName: "thepeoplescafe",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2516, // Food, The Breeze, 16
                name: "Sushi Tei",
                desc: "Sushi Tei is a Japanese restaurant chain that serves sushi, sashimi, and other Japanese dishes. It offers a modern dining experience with an open kitchen concept.",
                isFavorite: false,
                address: "The Breeze, Ground Floor",
                tags: ["food", "The Breeze", "Japanese"],
                imageName: "sushitei",
                operationalHours: "10:00 - 21:30 WIB"
            ),
            Building(
                id: 2517, // Food, The Breeze, 17
                name: "Brewerkz",
                desc: "Brewerkz BSD is a place where you can enjoy great food in a semi-outdoor setting, with billiards available next door.",
                isFavorite: false,
                address: "The Breeze, Ground Floor",
                tags: ["food", "The Breeze"],
                imageName: "brewerkz",
                operationalHours: "11:00 - 00:00 WIB"
            ),
            Building(
                id: 2518, // Food, The Breeze, 18
                name: "Wee Nam Kee",
                desc: "Wee Nam Kee is a Singaporean restaurant chain serving Hainanese chicken rice and other Asian dishes, with a casual dining atmosphere and Peranakan-inspired interior.",
                isFavorite: false,
                address: "The Breeze, Ground Floor",
                tags: ["food", "The Breeze", "Singaporean"],
                imageName: "weenamkee",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2519, // Food, The Breeze, 19
                name: "Villa Capri",
                desc: "Villa Capri invites you to savor the authentic flavors of Italy in a warm and inviting atmosphere. Indulge in a delightful culinary journey.",
                isFavorite: false,
                address: "The Breeze BSD, Unit L No. 8",
                tags: ["food", "The Breeze", "Italian"],
                imageName: "villacapri",
                operationalHours: "10:00 - 21:30 WIB"
            ),
//            Building(
//                id: 2520, // Food, The Breeze, 20
//                name: "Auntie Anne’s",
//                desc: "Auntie Anne's is an international franchise chain selling pretzels, dips, and beverages, founded by Anne F. Beiler and her husband Jonas in 1988 in Pennsylvania, USA.",
//                isFavorite: false,
//                address: "The Breeze, Blok IU, No.07",
//                tags: ["food", "The Breeze", "snack"],
//                imageName: "auntieannes",
//                operationalHours: "10:00 - 22:00 WIB"
//            ),
            Building(
                id: 2521, // Coffee, The Breeze, 21
                name: "Kenangan Signature",
                desc: "Kenangan Signature is the premium version of Kopi Kenangan, offering a more luxurious coffee experience with an exclusive look and packaging.",
                isFavorite: false,
                address: "The Breeze, Unit L.26",
                tags: ["coffee", "The Breeze"],
                imageName: "kenangansignature",
                operationalHours: "08:00 - 22:00 WIB"
            ),
            Building(
                id: 2522, // Food, The Breeze, 22
                name: "Fruity",
                desc: "Fruity Indonesia is one of the pioneers in the juice retail business in Bandung, established in 1999.",
                isFavorite: false,
                address: "The Breeze, Blok IU 12C",
                tags: ["food", "The Breeze", "juice"],
                imageName: "fruity",
                operationalHours: "09:30 - 21:00 WIB"
            ),
//            Building(
//                id: 2523, // Food, The Breeze, 23
//                name: "Jittalada Royal Thai Cuisine",
//                desc: "At Jittlada you will experience the very best of Thailand's unique culinary delights with fresh ingredients. The restaurant features 2 VIP rooms and an outdoor concept dining area.",
//                isFavorite: false,
//                address: "The Breeze, L-21",
//                tags: ["food", "The Breeze", "Thai"],
//                imageName: "jittalada",
//                operationalHours: "11:00 - 22:00 WIB"
//            ),
            Building(
                id: 2524, // Drink, The Breeze, 24
                name: "Chatime",
                desc: "Chatime is a brewed tea beverage provider from Taiwan offering more than 50 flavor variants. In Indonesia, Chatime has been part of the Kawan Lama Group since 2011.",
                isFavorite: false,
                address: "The Breeze, Batik 1 L.10A",
                tags: ["drink", "The Breeze", "Taiwanese"],
                imageName: "chatime",
                operationalHours: "10:00 - 22:00 WIB"
            ),
//            Building(
//                id: 2521, // Drink, The Breeze, 21
//                name: "Colico",
//                desc: "Welcome to the tropical world of COLICO, where we serve refreshing juice made from 100% REAL fruits. COLICO brings the fun back to tropical fruit juice while ensuring quality and health benefits.",
//                isFavorite: false,
//                address: "The Breeze, IU & Booth IU.03",
//                tags: ["drink", "The Breeze", "Juice"],
//                imageName: "colico",
//                operationalHours: "10:00 - 22:00 WIB"
//            ),
            Building(
                id: 2532, // Beverage, The Breeze, 32
                name: "Re-Juve",
                desc: "Re.juve adalah merek minuman kesehatan yang menjual jus cold-pressed segar dan alami.",
                isFavorite: false,
                address: "The Breeze, Island Unit IU.19",
                tags: ["beverage", "The Breeze", "Healthy"],
                imageName: "rejuve",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2533, // Food, The Breeze, 33
                name: "Kitchenette",
                desc: "The cozy and inviting eatery where you can enjoy the comfort of home-style cooking in a casual and relaxed atmosphere.",
                isFavorite: false,
                address: "L.30 The Breeze BSD City",
                tags: ["food", "The Breeze", "Western"],
                imageName: "kitchenette",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2534, // Beverage, The Breeze, 34
                name: "Happy Lemon",
                desc: "Happy Lemon is a beverage chain located at The Breeze in BSD, Indonesia. It serves tea, smoothies, slushies, and more.",
                isFavorite: false,
                address: "The Breeze, Lantai Ground",
                tags: ["beverage", "The Breeze", "Tea"],
                imageName: "happylemon",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2535, // Beverage, The Breeze, 35
                name: "Starbucks",
                desc: "Franchise kedai kopi dari Seattle yang terkenal dengan teknik penyeduhan kopinya yang khas, camilan & Wi-Fi.",
                isFavorite: false,
                address: "The Breeze, Batik 3 L. 29",
                tags: ["beverage", "The Breeze", "Coffee"],
                imageName: "starbucks",
                operationalHours: "08:00 - 22:00 WIB"
            ),
            Building(
                id: 2536, // Food, The Breeze, 36
                name: "J.CO",
                desc: "J.CO Donuts & Coffee is an Indonesian restaurant chain that serves donuts, coffee, and frozen yogurt.",
                isFavorite: false,
                address: "The Breeze, Batik 4 L. 38",
                tags: ["food", "The Breeze", "Donuts"],
                imageName: "jco",
                operationalHours: "10:00 - 21:00 WIB"
            ),
            Building(
                id: 2537, // Dessert, The Breeze, 37
                name: "Sour Sally Frozen Yogurt",
                desc: "Sour Sally Non-Fat Frozen Yogurt or simply known as “Fro-yo” was the first of its kind in Indonesia back in 2008.",
                isFavorite: false,
                address: "The Breeze, Unit IU 10 Island",
                tags: ["dessert", "The Breeze", "Frozen Yogurt"],
                imageName: "soursally",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2538, // Food, The Breeze, 38
                name: "Food Court",
                desc: "The Breeze BSD City in Tangerang, Banten, Indonesia is a shopping mall with many restaurants, including a food court.",
                isFavorite: false,
                address: "The Breeze BSD City",
                tags: ["food", "The Breeze", "Food Court"],
                imageName: "foodcourt",
                operationalHours: "10:00 - 22:00 WIB"
            ),
//            Building(
//                id: 2522, // Food, The Breeze, 22
//                name: "Chateraise",
//                desc: "A Japanese bakery offering a variety of pastries and desserts with authentic Japanese flavors.",
//                isFavorite: false,
//                address: "The Breeze BSD City, IU 08",
//                tags: ["food", "The Breeze", "Japanese"],
//                imageName: "chateraise",
//                operationalHours: "10:00 - 22:00 WIB"
//            ),
            Building(
                id: 2523, // Food, The Breeze, 23
                name: "Jalarasa",
                desc: "Jalarasa. Food & Beverages. Labuhan Rasa Nusantara. Serving Indonesian cuisine with flavors from the sea, using high-quality and fresh ingredients that make your palate dance.",
                isFavorite: false,
                address: "The Breeze BSD City Blok L No.68A-68B",
                tags: ["food", "The Breeze", "Indonesian"],
                imageName: "jalarasa",
                operationalHours: "11:00 - 22:00 WIB"
            ),
            Building(
                id: 2524, // Shopping, The Breeze, 24
                name: "Ranch Market",
                desc: "Ranch Market is a supermarket offering high-quality and unique products, focusing on healthy lifestyle products like organic and gluten-free items, catering to high-end and middle-high customers.",
                isFavorite: false,
                address: "The Breeze, Pavilion 5 L.79",
                tags: ["shopping", "The Breeze", "Supermarket"],
                imageName: "ranchmarket",
                operationalHours: "08:00 - 22:00 WIB"
            ),
            Building(
                id: 2525, // Food, The Breeze, 25
                name: "Saigon Delight",
                desc: "The spacious atmosphere, tropical fresh décor, and authentic Vietnamese menu make Saigon Delight perfect for dining with your loved ones!",
                isFavorite: false,
                address: "The Breeze",
                tags: ["food", "The Breeze", "Vietnamese"],
                imageName: "saigondelight",
                operationalHours: "10:00 - 22:00 WIB"
            ),
            Building(
                id: 2526, // Shopping, The Breeze, 26
                name: "Optik Melawai",
                desc: "Optik Melawai offers a variety of exclusive optical products with a trusted reputation, targeting the middle to high-end market with high-quality products.",
                isFavorite: false,
                address: "The Breeze",
                tags: ["shopping", "The Breeze", "Optical"],
                imageName: "optikmelawai",
                operationalHours: "10:00 - 22:00 WIB"
            ),
//            Building(
//                id: 2527, // Food, The Breeze, 27
//                name: "Gubug Makan Mang Engking",
//                desc: "The menu features dishes like fried gurame with sambal, stir-fried water spinach, honey grilled prawns, honey grilled gurame, and many more.",
//                isFavorite: false,
//                address: "The Breeze BSD City, Unit L67 A-C",
//                tags: ["food", "The Breeze", "Indonesian"],
//                imageName: "gubugmakanmangengking",
//                operationalHours: "10:00 - 22:00 WIB"
//            ),
            Building(
                id: 2528, // Food, The Breeze, 28
                name: "Slice of Heaven",
                desc: "Slice of Heaven at The Breeze BSD City is a Japanese restaurant and café serving fusion food, located inside Spincity Bowling Alley.",
                isFavorite: false,
                address: "The Breeze BSD City L 60 - 61",
                tags: ["food", "The Breeze", "Japanese"],
                imageName: "sliceofheaven",
                operationalHours: "11:00 - 22:00 WIB"
            ),
            Building(
                id: 2529, // Entertainment, The Breeze, 29
                name: "Spincity",
                desc: "Spincity Bowling Alley is a bowling entertainment center where you can have fun playing bowling and enjoy casual dining with friends and family.",
                isFavorite: false,
                address: "The Breeze BSD City",
                tags: ["entertainment", "The Breeze", "Bowling"],
                imageName: "spincity",
                operationalHours: "10:00 - 22:00 WIB"
            ),
//            Building(
//                id: 2530, // Food, The Breeze, 30
//                name: "Gion",
//                desc: "Sushi and Japanese dishes beautifully served in a spacious area with large windows and a vaulted ceiling.",
//                isFavorite: false,
//                address: "The Breeze #L-59",
//                tags: ["food", "The Breeze", "Japanese"],
//                imageName: "gion",
//                operationalHours: "10:00 - 22:00 WIB"
//            ),
//            Building(
//                id: 2529, // Food, The Breeze, 29
//                name: "Subway",
//                desc: "A casual counter-serve chain for build-your-own sandwiches and salads, with plenty of healthy options.",
//                isFavorite: false,
//                address: "The Breeze BSD City Lake Level L57A",
//                tags: ["food", "The Breeze", "Fast Food"],
//                imageName: "subway",
//                operationalHours: "09:00 - 22:00 WIB"
//            ),
            Building(
                id: 2530, // Shopping, The Breeze, 30
                name: "RELX",
                desc: "RELX is an electronic cigarette brand offering a range of vape devices and pods. Official RELX products are available at RELX Indonesia stores.",
                isFavorite: false,
                address: "The Breeze",
                tags: ["shopping", "The Breeze", "Lifestyle"],
                imageName: "relx",
                operationalHours: "10:00 - 22:00 WIB"
            ),
//            Building(
//                id: 2531, // Shopping, The Breeze, 31
//                name: "Boots Beauty",
//                desc: "Boots Indonesia is a health and beauty store located in The Breeze BSD City, offering skincare, body care, and medicine products.",
//                isFavorite: false,
//                address: "The Breeze, L63A - Lake Level",
//                tags: ["shopping", "The Breeze", "Beauty"],
//                imageName: "bootsbeauty",
//                operationalHours: "10:00 - 22:00 WIB"
//            ),
            Building(
                id: 2301, // Food, Traveloka Campus, 01
                name: "FamilyMart",
                desc: "FamilyMart Company, Ltd. adalah rantai waralaba toko serba ada dari Jepang. Toko FamilyMart menyediakan barang-barang khas toko serba ada Jepang, seperti makanan dan minuman ringan, ayam goreng, onigiri/omusubi (nasi kepal) dan masih banyak lagi. Menu rekomendasi untuk FamilyMart adalah Kopi Susu Keluarga (KSK), oden dan tteokbokki. FamilyMart juga sering menawarkan promo-promo menarik seperti diskon khusus pada jam-jam tertentu sehingga dapat belanja lebih hemat.",
                isFavorite: false,
                address: "Lt. B1 Gedung Traveloka Campus",
                tags: ["food", "drink", "GOP 1"],
                imageName: "familymart",
                operationalHours: "06:00 - 20:00 WIB"
            ),
//            Building(
//                id: 2302, // Food, Traveloka Campus, 02
//                name: "Kantin Dapur Kencana",
//                desc: "Kantin Dapur Kencana adalah sebuah kantin yang terletak di Basement 1, Gedung Green Office Park 1. Kantin ini menawarkan suasana nyaman dan praktis untuk menikmati berbagai pilihan makanan dan minuman yang lezat dengan harga terjangkau. Menu yang disajikan bervariasi, mencakup hidangan khas Indonesia seperti nasi goreng, soto, dan aneka lauk tradisional, serta opsi makanan ringan dan minuman segar untuk memenuhi selera beragam pelanggan.",
//                isFavorite: false,
//                address: "Lt. B1 Gedung Traveloka Campus",
//                tags: ["GOP 1", "food", "drink"],
//                imageName: "dapurkencana",
//                operationalHours: "06:00 - 13:00 WIB"
//            )
            Building(
                id: 6301, // Facility, Traveloka Campus, 01
                name: "Mushola GOP 1",
                desc: "Tempat ibadah umat muslim dan muslimah. Mushola disini luas, dingin dan bersih sehingga nyaman dalam melakukan ibadah.",
                isFavorite: false,
                address: "Lt. B2 Gedung Traveloka Campus",
                tags: ["mushola", "GOP 1"],
                imageName: "mushola",
                operationalHours: "06:00 - 00:00 WIB"
            ),
            Building(
                id: 5301, // Facility, Traveloka Campus, 01
                name: "Toilet GOP 1",
                desc: "Tempat untuk melakukan aktivitas terkait sanitasi. Toilet disini tentunya bersih dan wangi.",
                isFavorite: false,
                address: "Lt. B1 Gedung Traveloka Campus/GOP1, dekat FamilyMart",
                tags: ["toilet", "GOP 1"],
                imageName: "toilet",
                operationalHours: "06:00 - 00:00 WIB"
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
        .modelContainer(for: Building.self)
}

