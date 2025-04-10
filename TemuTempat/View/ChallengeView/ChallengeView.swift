import SwiftUI

struct ChallengeView: View {
    @AppStorage("completedChallenges") private var completedChallenges: Int = 0
    @AppStorage("completedChallengesList") private var completedChallengesList: String = ""
    
    @State private var showingQuiz: Bool = false
    // Perbaikan bug: Ganti nilai default "Bug" dengan challenge pertama yang valid
    @State private var selectedChallenge: (challengeName: String, challengeDesc: String) = (challengeName: "", challengeDesc: "")
    
    let challenges: [(challengeName: String, challengeDesc: String)] = [
        (challengeName: "Get To Know GOP 6", challengeDesc: "Dive into the essential spots inside GOP 6! This challenge will test your knowledge about Lawson GOP 6, the cleanliness of the toilets, the functionality of the mushola (prayer room), promotion tips, and the main features of the GOP 6 canteen. Perfect for those who want to master what GOP 6 has to offer."),
        (challengeName: "Get to Know GOP 9", challengeDesc: "Are you familiar with the hidden gems of GOP 9? In this challenge, discover the convenience of Green Eatery’s services, Alfamart Express’s shopping advantages, special facilities at the basement toilets, and the unique design of the GOP 9 mushola. Test yourself and become a true GOP 9 expert!."),
        (challengeName: "Get To Know GOP 1", challengeDesc: "Ready to explore GOP 1 like a true insider? In this challenge, discover the favorite menu at FamilyMart Traveloka Campus, the lively vibe of Dapur Kencana canteen, operation hours you shouldn't miss, and the impressive facilities like the mushola and toilets. Sharpen your knowledge and experience GOP 1 at its best!."),
        (challengeName: "The Breeze Foodie’s Battle", challengeDesc: "Think you know all the foodie spots at The Breeze? In this challenge, explore everything from fresh Vietnamese dishes and elegant Japanese sushi to healthy sandwiches. Put your foodie knowledge to the test and prove you're the ultimate The Breeze food explorer!."),
        (challengeName: "The Breeze Shopping Explorer", challengeDesc: "Are you familiar with all the trendy shopping spots at The Breeze? This challenge invites you to explore optical stores, lifestyle boutiques, and beauty shops. Show that you're a true shopaholic and a master of The Breeze shopping scene!."),
        (challengeName: "Entertainment & Fun at The Breeze", challengeDesc: "Test your knowledge of the most exciting entertainment spots at The Breeze! From fun hangout locations to perfect family destinations, this challenge will see if you truly know where the best adventures at The Breeze begin."),
        (challengeName: "The Breeze and Green Office Park Explorer", challengeDesc: "The Breeze and Green Office Park Explorer challenge invites participants to delve into BSD City's innovative landmarks: The Breeze, Indonesia's first mall without walls, offering open-air lifestyle experiences amidst lush greenery and scenic lakes, and the Green Office Park, a 25-hectare eco-friendly business district designed with sustainable features and extensive green spaces "),
        (challengeName: "Green Office Park Facilities Hunt", challengeDesc: "​This challenge is designed to test your knowledge of the eco-friendly facilities and features offered by Green Office Park BSD City, Indonesia's first green office complex that integrates sustainability concepts into its design and operations."),
        (challengeName: "(More) Shopping Spots at The Breeze", challengeDesc: "Explore the variety of shopping destinations at The Breeze! In this challenge, dive into eyewear shops, beauty stores, and trendy lifestyle boutiques. Perfect for those who love a good shopping spree and want to know all the best spots!"),
        (challengeName: "The Breeze Entertainment & Fun", challengeDesc: "Get ready for some fun and adventure at The Breeze! In this challenge, discover exciting entertainment spots like bowling alleys and hidden cafés. Test your knowledge and find out how well you know The Breeze’s most fun and unique locations!"),
    ]
    
    private let primaryBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    private let lightBlue = Color(red: 0.9, green: 0.95, blue: 1.0)
    private let mediumBlue = Color(red: 0.7, green: 0.85, blue: 1.0)
    
    var completedChallengesSet: Set<String> {
        Set(completedChallengesList.components(separatedBy: ",").filter { !$0.isEmpty })
    }
    
    func markChallengeCompleted(_ challenge: String) {
        if !completedChallengesSet.contains(challenge) {
            completedChallengesList += completedChallengesList.isEmpty ? challenge : ",\(challenge)"
            completedChallenges += 1
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Challenges")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Text("Complete challenges to earn rewards")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                                
                                HStack {
                                    Text("Completed: \(completedChallenges)/\(challenges.count)")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(primaryBlue)
                                    Spacer()
                                }
                                .padding(.top, 4)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16)
                            ], spacing: 16) {
                                ForEach(challenges, id: \.challengeName) { challenge in
                                    ChallengeCardFullScreen(
                                        action: {
                                                selectedChallenge = challenge
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                    showingQuiz = true
                                                }
                                        },
                                        challenge: challenge,
                                        isCompleted: completedChallengesSet.contains(challenge.challengeName),
                                        primaryColor: primaryBlue,
                                        backgroundColor: lightBlue
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showingQuiz) {
                QuizViewFullScreen(
                    challenge: $selectedChallenge,
                    isPresented: $showingQuiz,
                    markChallengeCompleted: markChallengeCompleted
                )
            }
        }
    }
}

struct QuizViewFullScreen: View {
    @Binding var challenge: (challengeName: String, challengeDesc: String)

    @Binding var isPresented: Bool
    var markChallengeCompleted: (String) -> Void
    
    @State private var selectedAnswer: Int? = nil
    @State private var questionIndex: Int = 0
    @State private var score: Int = 0
    @State private var showResult: Bool = false
    @AppStorage("completedChallenges") private var completedChallenges: Int = 0
    @AppStorage("completedChallengesList") private var completedChallengesList: String = ""
    
    private let primaryBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    private let lightBlue = Color(red: 0.9, green: 0.95, blue: 1.0)
    
    let challengeQuestions: [String: [(question: String, answers: [String], correctAnswer: Int)]] = [
        "Get To Know GOP 6": [
            ("Lawson GOP 6 berlokasi di lantai yang sama dengan fasilitas apa berikut ini?",
             ["Mushola", "Kantin GOP 6", "Lobby utama", "Rooftop garden"], 1),
            ("Apa aspek yang paling ditekankan tentang Toilet GOP 6 dalam deskripsi aplikasi?",
             ["Tersedia ruang menyusui", "Desain mewah", "Kebersihan dan aroma segar", "Toilet duduk elektrik"], 2),
            ("Mushola GOP 6 dirancang untuk memenuhi kebutuhan apa?",
             ["Ibadah umum dan acara keagamaan besar", "Sholat harian untuk karyawan dan pengunjung",
              "Workshop keagamaan mingguan", "Belajar mengaji bersama komunitas"], 1),
            ("Apa yang disarankan aplikasi saat ingin mencari promo terbaru dari Lawson GOP 6?",
             ["Bertanya langsung ke kasir", "Cek papan pengumuman GOP 6",
              "Mengikuti akun sosial media resmi", "Mendaftar kartu member"], 2),
            ("Apa karakteristik utama Kantin GOP 6 menurut aplikasi?",
             ["Tempat makan outdoor luas", "Pilihan makanan beragam dan harga terjangkau",
              "Kantin dengan layanan full service", "Area VIP eksklusif untuk tamu penting"], 1)
        ],
        "Get to Know GOP 9": [
            ("Apa keunggulan layanan tambahan yang disebutkan di Green Eatery GOP 9?",
             ["Layanan antar makanan ke meja", "Pick-up service lewat WhatsApp",
              "Reservasi tempat duduk online", "Diskon khusus member"], 1),
            ("Apa yang menjadi daya tarik tambahan saat berbelanja di Alfamart Express GOP 9?",
             ["Pembayaran eksklusif hanya tunai", "Hadiah langsung setiap belanja",
              "Promo diskon dan paket hemat", "Fasilitas drive-thru belanja"], 2),
            ("Fasilitas tambahan apa yang tersedia di Toilet Basement GOP 9?",
             ["Baby changing station", "Shower room", "Ruang tunggu", "Alat pijat otomatis"], 1),
            ("Apa keunikan Mushola GOP 9 dibandingkan dengan biasanya?",
             ["Terletak di rooftop GOP 9", "Tersedia dua lokasi mushola dekat Green Eatery",
              "Memiliki area khusus untuk wudhu perempuan", "Membuka kelas kajian mingguan"], 1),
            ("Green Eatery GOP 9 lebih dikenal dengan nama lain, yaitu?",
             ["Dapur Kasturi", "Green Bites", "Green Cafe", "Green Eatery"], 3)
        ],
        "Get To Know GOP 1": [
            ("Apa salah satu menu rekomendasi yang disebutkan di FamilyMart Traveloka Campus?",
             ["Chicken Katsu Bento", "Kopi Susu Keluarga (KSK)", "Es Kopi Vietnam", "Takoyaki"], 1),
            ("Apa ciri khas suasana yang ditawarkan Kantin Dapur Kencana di GOP 1?",
             ["Mewah dan eksklusif", "Tradisional dan ramai", "Nyaman dan praktis", "Artistik dan modern"], 2),
            ("Di jam berapa FamilyMart Traveloka Campus mulai beroperasi?",
             ["07.00 WIB", "05.30 WIB", "06.00 WIB", "08.00 WIB"], 2),
            ("Apa keunggulan Mushola di GOP 1 menurut deskripsi?",
             ["Memiliki perpustakaan kecil", "Luas, dingin, dan bersih",
              "Terpisah untuk laki-laki dan perempuan", "Terdapat kantin kecil di dalamnya"], 1),
            ("Apa kualitas yang ditekankan pada Toilet GOP 1?",
             ["Tersedia ruang bilas bayi", "Desain minimalis modern",
              "Kebersihan dan aroma segar", "Toilet ramah difabel"], 2)
        ],
        "The Breeze Foodie’s Battle": [
            ("Restoran mana yang menawarkan atmosfer tropis dan menu autentik Vietnam?",
             ["Gion", "Subway", "Saigon Delight", "Slice of Heaven"], 2),
            ("Apa menu andalan Gubug Makan Mang Engking?",
             ["Sushi Fusion", "Fried Gurame dengan sambal", "Grilled Chicken Salad", "Vietnamese Pho"], 1),
            ("Slice of Heaven berlokasi di mana di The Breeze BSD City?",
             ["Lake Level L57A", "Unit L67 A-C", "L 60-61, dalam Spincity Bowling Alley", "The Breeze #L-59"], 2),
            ("Restoran apa yang terkenal dengan konsep 'build-your-own sandwich'?",
             ["Gubug Makan Mang Engking", "Subway", "Gion", "Saigon Delight"], 1),
            ("Gion di The Breeze dikenal dengan desain seperti apa?",
             ["Outdoor seating di tepi danau", "Indoor tropical decor",
              "Area luas dengan jendela besar dan langit-langit tinggi", "Lounge bergaya industrial"], 2),
            ("Jam operasional Saigon Delight adalah:",
             ["09:00 - 22:00 WIB", "10:00 - 22:00 WIB", "11:00 - 22:00 WIB", "10:00 - 21:00 WIB"], 1),
            ("Menu di Slice of Heaven menggabungkan unsur makanan dari negara mana?",
             ["Jepang", "Vietnam", "Thailand", "Korea"], 0),
            ("Gubug Makan Mang Engking beralamat di:",
             ["The Breeze BSD City L 60-61", "The Breeze BSD City Lake Level L57A",
              "The Breeze BSD City, Unit L67 A-C", "The Breeze #L-59"], 2)
        ],
        "The Breeze Shopping Explorer": [
            ("Toko mana di The Breeze yang fokus menjual produk kacamata eksklusif?",
             ["Boots Beauty", "RELX", "Optik Melawai", "Gion"], 2),
            ("RELX di The Breeze menjual produk apa?",
             ["Skincare dan body care", "Vape dan perangkat elektronik rokok",
              "Fashion dan aksesoris", "Sandwich dan salad"], 1),
            ("Boots Beauty menawarkan produk-produk apa di The Breeze?",
             ["Gadget dan elektronik", "Skincare, body care, dan obat-obatan",
              "Alat olahraga dan gym", "Produk otomotif"], 1),
            ("Alamat Boots Beauty di The Breeze adalah:",
             ["Unit L67 A-C", "L63A - Lake Level", "The Breeze #L-59", "Lake Level L57A"], 1),
            ("Jam operasional Optik Melawai adalah:",
             ["09:00 - 21:00 WIB", "10:00 - 22:00 WIB", "11:00 - 23:00 WIB", "10:00 - 20:00 WIB"], 1),
            ("Produk resmi RELX di Indonesia bisa ditemukan di mana di The Breeze?",
             ["Slice of Heaven", "RELX Store", "Optik Melawai", "Boots Beauty"], 1),
            ("Toko mana yang masuk kategori 'Lifestyle' di The Breeze?",
             ["Boots Beauty", "RELX", "Optik Melawai", "Spincity"], 1),
            ("Kategori Boots Beauty lebih fokus ke:",
             ["Makanan dan minuman", "Kesehatan dan kecantikan",
              "Permainan anak-anak", "Fasilitas olahraga"], 1),
            ("Produk seperti serum wajah dan sabun mandi bisa ditemukan di:",
             ["RELX", "Optik Melawai", "Boots Beauty", "Slice of Heaven"], 2)
        ],
        "Entertainment & Fun at The Breeze": [
            ("Spincity di The Breeze dikenal sebagai tempat untuk aktivitas apa?",
             ["Karaoke", "Bowling", "Ice skating", "Gym"], 1),
            ("Selain bermain bowling, pengunjung Spincity juga bisa melakukan apa?",
             ["Menikmati casual dining", "Belanja alat olahraga", "Bermain trampolin", "Mengikuti kelas yoga"], 0),
            ("Slice of Heaven berlokasi di mana di dalam The Breeze?",
             ["Di dalam pusat optik", "Di dalam Spincity Bowling Alley", "Di dekat RELX store", "Di samping Subway"], 1),
            ("Menu makanan di Slice of Heaven cenderung ke arah mana?",
             ["Western klasik", "Fusion Jepang", "Korean BBQ", "Indonesian street food"], 1),
            ("Ciri khas suasana di Spincity adalah:",
             ["Cozy dan tropical", "Sporty dan fun", "Minimalis dan elegan", "Vintage dan retro"], 1),
            ("Apa kelebihan Slice of Heaven dibanding tempat makan lainnya di The Breeze?",
             ["Hanya menyediakan makanan berat", "Berada dalam area bowling, cocok buat ngemil sambil main",
              "Khusus untuk vegetarian", "Fokus pada makanan Italia otentik"], 1),
            ("Spincity Bowling Alley cocok untuk acara:",
             ["Meeting kantor", "Acara olahraga keluarga dan teman", "Seminar kesehatan", "Workshop kerajinan tangan"], 1),
            ("Slice of Heaven merupakan restoran dengan pengaruh makanan dari negara mana?",
             ["Korea", "Jepang", "Thailand", "India"], 1),
            ("Suasana di Slice of Heaven bisa digambarkan sebagai:",
             ["Ramai dan serba neon", "Santai dan modern", "Tradisional dan kuno", "Gelap dan formal"], 1),
            ("Siapa yang paling cocok mengunjungi Spincity Bowling Alley dan Slice of Heaven?",
             ["Pecinta fashion high-end", "Orang yang mencari pengalaman fun bersama keluarga atau teman",
              "Penggemar relaksasi spa", "Kolektor barang elektronik"], 1)
        ],
        "The Breeze and Green Office Park Explorer": [
            ("Toko mana di The Breeze yang dikenal sebagai 'mall tanpa dinding'?",
             ["The Breeze", "Teraskota", "AEON Mall", "Summarecon Mall"], 0),
            ("Fasilitas apa yang tersedia di Green Office Park BSD City?",
             ["Layanan keamanan 24/7", "Kafetaria terintegrasi", "Terhubung langsung ke The Breeze", "Semua jawaban benar"], 3),
            ("Berapa persen ruang terbuka hijau yang dimiliki oleh Green Office Park BSD City?",
             ["50%", "55%", "60%", "62%"], 3),
            ("Green Office Park BSD City mendapatkan sertifikasi 'Gold' Green District dari lembaga mana?",
             ["Green Building Council Indonesia (GBCI)", "Building and Construction Authority (BCA) Singapore", "World Green Building Council (WGBC)", "Kementerian Lingkungan Hidup Indonesia"], 1),
            ("Fasilitas olahraga apa yang tersedia di Green Office Park BSD City?",
             ["Lapangan tenis", "Kolam renang", "Jogging track sepanjang 1 km", "Gym indoor"], 2),
            ("The Breeze BSD City dikenal sebagai pusat perbelanjaan yang ramah terhadap:",
             ["Anak-anak", "Hewan peliharaan", "Lansia", "Penyandang disabilitas"], 1),
            ("Apa konsep utama yang diterapkan oleh Green Office Park BSD City dalam pengembangan kawasannya?",
             ["Pembangunan berkelanjutan", "Pusat teknologi", "Kawasan industri", "Pusat hiburan malam"], 0),
            ("Gedung perkantoran mana di Green Office Park yang telah meraih sertifikasi Gold Greenship dari GBCI?",
             ["Green Office Park 1", "Green Office Park 6", "Green Office Park 9", "Semua jawaban benar"], 3),
            ("Apa nama gedung di Green Office Park yang dikunjungi oleh CEO Apple, Tim Cook?",
             ["Green Office Park 1", "Green Office Park 6", "Green Office Park 9", "Apple Developer Academy"], 3),
            ("Kapan Sinar Mas Land meresmikan gedung perkantoran Green Office Park 6?",
             ["2014", "2015", "2016", "2017"], 2)
        ],
        "Green Office Park Facilities Hunt": [
            ("Berapa jumlah bangunan perkantoran yang ada di Green Office Park BSD City?",
             ["7", "9", "11", "13"], 2),
            ("Fasilitas apa yang disediakan di Green Office Park untuk mendukung mobilitas ramah lingkungan?",
             ["Jalur sepeda dan shower room", "Stasiun pengisian kendaraan listrik", "Shuttle bus listrik", "Semua jawaban benar"], 3),
            ("Sertifikasi lingkungan apa yang telah diraih oleh Green Office Park BSD City?",
             ["LEED Platinum", "Gold Greenship dari GBCI", "Green Mark Gold dari BCA Singapore", "ISO 14001"], 1),
            ("Berapa luas area Green Office Park BSD City?",
             ["20 hektar", "25 hektar", "30 hektar", "35 hektar"], 1),
            ("Fitur ramah lingkungan apa yang diterapkan di gedung-gedung Green Office Park?",
             ["Penggunaan kaca khusus untuk mengurangi panas", "Lampu tenaga surya untuk penerangan jalan", "Sistem pengelolaan air dan limbah yang efisien", "Semua jawaban benar"], 3)
        ],
        "(More) Shopping Spots at The Breeze": [
            ("Tempat mana di The Breeze yang terkenal menjual produk optik berkualitas tinggi?",
             ["RELX", "Optik Melawai", "Boots Beauty", "Gion"], 1),
            
            ("Optik Melawai dikenal melayani segmen pasar seperti apa?",
             ["Remaja trendi", "Middle to high-end market", "Hobi kolektor", "Penggemar kuliner"], 1),
            
            ("RELX di The Breeze menawarkan produk apa?",
             ["Kacamata eksklusif", "Vape dan pod elektronik", "Skincare premium", "Produk fashion"], 1),
            
            ("Di RELX, produk yang ditawarkan termasuk:",
             ["Sepatu olahraga", "Elektronik dan vape devices", "Home décor", "Aksesori kamera"], 1),
            
            ("Boots Beauty di The Breeze lebih fokus ke kategori produk apa?",
             ["Elektronik dan gadgets", "Food and beverage",
              "Skincare, body care, dan medicine", "Bowling equipment"], 2),
            
            ("Di mana lokasi Boots Beauty di The Breeze?",
             ["The Breeze BSD City L 60 - 61", "The Breeze, L63A - Lake Level",
              "The Breeze BSD City, Unit L67 A-C", "The Breeze #L-59"], 1),
            
            ("Apa ciri khas utama produk yang ditawarkan di Boots Beauty?",
             ["Fokus pada fast food", "Fokus pada kesehatan dan kecantikan",
              "Fokus pada olahraga dan fitness", "Fokus pada otomotif"], 1),
            
            ("Siapa yang paling cocok berbelanja di Boots Beauty?",
             ["Pecinta kuliner Jepang", "Orang yang mencari perawatan tubuh dan kesehatan",
              "Penggemar bowling", "Penikmat kopi"], 1),
            
            ("Kalau kamu butuh vape device resmi, ke mana kamu harus pergi di The Breeze?",
             ["Subway", "RELX", "Boots Beauty", "Gion"], 1),
        ],
        "The Breeze Entertainment & Fun": [
            ("Di mana kamu bisa bermain bowling di The Breeze BSD City?",
             ["Spincity", "Subway", "RELX", "Slice of Heaven"], 0),
            
            ("Slice of Heaven berlokasi di area apa di The Breeze BSD City?",
             ["Lake Level L57A", "Spincity Bowling Alley", "The Breeze #L-59", "Gubug Makan Mang Engking"], 1),
            
            ("Jenis makanan utama apa yang disajikan di Slice of Heaven?",
             ["Vietnamese authentic food", "Indonesian street food",
              "Japanese fusion cuisine", "Fast food sandwiches"], 2),
            
            ("Apa yang membuat Spincity Bowling Alley spesial dibanding tempat hiburan lain di The Breeze?",
             ["Ada karaoke room", "Ada casual dining restaurant di dalamnya",
              "Ada toko vape RELX", "Ada area shopping optik"], 1),
            
            ("Gaya desain seperti apa yang menggambarkan suasana Spincity?",
             ["Formal dan elegan", "Santai dan fun",
              "Tradisional dan klasik", "Vintage dan retro"], 1),
            
            ("Siapa yang paling cocok mengunjungi Spincity?",
             ["Pecinta shopping mewah", "Keluarga dan teman yang ingin bermain",
              "Kolektor skincare dan kosmetik", "Penggemar sushi high-end"], 1),
            
            ("Selain bowling, apa lagi yang bisa kamu lakukan di Spincity?",
             ["Makan fusion Japanese food di Slice of Heaven", "Belanja produk optik premium",
              "Membeli vape devices", "Makan sandwich sehat"], 0),
            
            ("Nama 'Slice of Heaven' mengisyaratkan suasana apa?",
             ["Sporty dan kompetitif", "Kasual dan menyenangkan",
              "Fancy dan eksklusif", "Rame dan tradisional"], 1),
        ]
    ]
    
    var questions: [(question: String, answers: [String], correctAnswer: Int)] {
        challengeQuestions[challenge.challengeName] ?? []
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(10)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    Text(challenge.challengeName)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    Color.clear
                        .frame(width: 36, height: 36)
                        .padding(.trailing, 20)
                        .padding(.top, 20)
                }
                
                if showResult {
                    VStack(spacing: 24) {
                        VStack(spacing: 8) {
                            Image(systemName: score >= questions.count / 2 ? "trophy.fill" : "xmark.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(score >= questions.count / 2 ? .yellow : .red)
                                .padding(.bottom, 10)
                            Text("Quiz Completed!")
                                .font(.system(size: 28, weight: .bold))
                            Text("Your Score: \(score) / \(questions.count)")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 40)
                        
                        Text(score >= questions.count / 2 ?
                             "Congratulations! You've successfully completed this challenge." :
                             "Keep practicing! You need to score at least 50% to complete this challenge.")
                            .font(.system(size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                        
                        Button("Back to Challenges") {
                            if Double(score) / Double(questions.count) >= 0.5 {
                                markChallengeCompleted(challenge.challengeName)
                            }
                            isPresented = false
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(primaryBlue)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                } else if questionIndex < questions.count {
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Question \(questionIndex + 1) of \(questions.count)")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("Score: \(score)")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(primaryBlue)
                            }
                            
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .frame(width: geometry.size.width, height: 8)
                                        .opacity(0.1)
                                        .foregroundColor(primaryBlue)
                                    
                                    Rectangle()
                                        .frame(width: questions.count > 1 ? min(CGFloat(questionIndex) / CGFloat(questions.count - 1) * geometry.size.width, geometry.size.width) : geometry.size.width, height: 8) // Fix: Avoid division by zero
                                        .foregroundColor(primaryBlue)
                                }
                                .cornerRadius(4)
                            }
                            .frame(height: 8)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        Text(questions[questionIndex].question)
                            .font(.system(size: 22, weight: .bold))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                        VStack(spacing: 12) {
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    selectedAnswer = index
                                }) {
                                    HStack {
                                        Text(questions[questionIndex].answers[index])
                                            .font(.system(size: 16))
                                            .foregroundColor(selectedAnswer == index ? .white : .black)
                                            .padding(.leading, 16)
                                        Spacer()
                                        if selectedAnswer == index {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.white)
                                                .padding(.trailing, 16)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 60)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(selectedAnswer == index ? primaryBlue : lightBlue)
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer()
                        
                        Button(action: {
                            if selectedAnswer == questions[questionIndex].correctAnswer {
                                score += 1
                            }
                            if questionIndex < questions.count - 1 {
                                questionIndex += 1
                                selectedAnswer = nil
                            } else {
                                showResult = true
                            }
                        }) {
                            Text(questionIndex == questions.count - 1 ? "Submit" : "Next Question")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(selectedAnswer != nil ? primaryBlue : Color.gray.opacity(0.3))
                                .cornerRadius(12)
                        }
                        .disabled(selectedAnswer == nil)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                } else {
                    // Fallback for empty questions
                    VStack {
                        Text("No questions available for this challenge.")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                        Spacer()
                        Button("Back to Challenges") {
                            isPresented = false
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(primaryBlue)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .statusBar(hidden: true)
    }
}

#Preview {
    ChallengeView()
}


struct ChallengeCardFullScreen: View {
    let action: () -> Void
    let challenge: (challengeName: String, challengeDesc: String)
    let isCompleted: Bool
    let primaryColor: Color
    let backgroundColor: Color
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 12) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(challenge.challengeName)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                        if isCompleted {
                            Text("Completed")
                                .font(.system(size: 11))
                                .foregroundColor(.green)
                                .padding(.top, 4)
                        }
                    }
                    Spacer()
                }
                Text(challenge.challengeDesc) // Fix: Use Text to display challengeDesc
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("Start Challenge")
                        .font(.system(size: 12, weight: .semibold))
                    Image(systemName: "arrow.right")
                        .font(.system(size: 12, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(primaryColor)
                .cornerRadius(12)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isCompleted ? Color.green.opacity(0.5) : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
