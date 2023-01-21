import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/validation.dart';
import 'package:home_page/widget/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool state = true;
  String gender = 'Male';
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String? path;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    setData();
  }

  bool isLoading = true;

  void setData() async {
    final res = await FirebaseFirestore.instance
        .collection("users")
        .doc(UserProfile.id)
        .get();
    if (res.data() != null) {
      final data = res.data();
      setState(() {
        _nameController.text = data!['name'];
        _userNameController.text = data['userName'];
        dob.text = data['dob'];
        _mailController.text = data['email'];
        _mobileController.text = data['mobile'];
        gender = data['gender'];
        path = data['profile'];
        isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> data = [
    {
      "name": "Pink Beach",
      "location": "Asia",
      "show_location": "West Asia",
      "price": 2500,
      "description":
          "Lombok is an island in Indonesia, famous for its giant active volcano Mount Rinjani (or ‘Gunung Rinjani’). Lombok is part of the Lesser Sunda Islands, of which its nearest neighbour is the famous Island of Bali. \n\nOn Lombok Island you’ll find the culture is heavily influenced by the neighbouring island of Bali. Like the Balinese, the Lombok people are predominantly Muslim – inheriting their religion from the original settlers of Lombok, who were known as the Sasak. \n\nPink Beach (Pantai Tangsi) sits at the edge of a tiny fishing village called Sekaroh in the district of Jerowaru on the Ekas Peninsula, an extremely remote area of Lombok’s east coast.",
      "images": [
        "https://external-preview.redd.it/P27URL9OW8NfZvNuJWikyRCPWOupBPs1dSHfYsKsPLY.jpg?auto=webp&s=b04811eb285c2c1292ea1c64803b6dff0d105e6a",
        "https://www.planetware.com/wpimages/2020/09/world-best-pink-sand-beaches-elafonissi-beach-greece.jpg",
        "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/elafonisi-lagoon-crete-island-greece-royalty-free-image-577324858-1551472750.jpg?crop=0.84371xw:1xh;center,top&resize=480:*",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2FaYEmG95LcmLem0V_WCz3POSrQ1P_8gXPNmNxWv7EwdVNkbXJjpAl9jO8JIMkD2ZZP8&usqp=CAU",
        "https://images.unsplash.com/photo-1562008928-6185cc645f76?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGluayUyMGJlYWNofGVufDB8fDB8fA%3D%3D&w=1000&q=80",
        "https://www.travelandleisure.com/thmb/B9aLIeZ_p3C0WyKKQ8ma_izGimE=/1600x1000/filters:fill(auto,1)/Pink-Sand-Beach-Harbour-Island-The-Bahamase-PINKBEACHES1117-4e4ae197d53a4f55a863429b5390b667.jpg",
        "https://i.pinimg.com/originals/bc/52/48/bc5248497996721ce81d9430ccfb1cbb.png",
        "https://i.pinimg.com/736x/85/4d/19/854d199909a0375c60dcfa6aa225f4c6--pink-sunset-pink-beach.jpg",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Koh Yao Yai",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 2700,
      "description":
          "Ko Yao Yai is a Thai island in the Andaman Sea, halfway between Phuket and Krabi. It's characterized by sandy shores, mangroves, rubber plantations and fishing villages. Beaches include Loh Paret and Loh Jark, the latter with a pier for ferries and long-tail boats. The surrounding waters are rich in coral and dotted with dive sites, like the King Cruiser Wreck near Anemone Reef, and the pinnacles of Shark Point. \n Max length: 30 km \n\nKo Yao Yai is the larger of the two big islands in the Ko Yao Archipelago. The island group is in Phang Nga Bay in the Phang Nga Province of southern Thailand. Ko Yao Yai means 'big long island'. The other main island of the group is Ko Yao Noi ('little long island'), off Ko Yao Yai's north side and separated from it by a narrow sound. The two islands form Phang Nga's Ko Yao District. The population of Ko Yao is about 18,000 (2018). Ninety percent are Muslims. The area of the archipelago is 147 km2. It lies some 600 km south of Bangkok and about 50 km from Phuket or Phang Nga. Ko Kao Noi is more popular with visitors as it has more facilities.",
      "images": [
        "https://pix10.agoda.net/hotelImages/335179/-1/1357801386bc408525f15c80dff1c435.png?ce=0&s=1024x768",
        "https://www.jahnreisen.de/pibe-media/mwr/hotel/HKT30023-FZ_S22_13.jpg",
        "https://www.oyster.com/wp-content/uploads/sites/35/2019/05/pool-v6759879-1440-1024x683.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-s/09/00/90/d3/santhiya-koh-yao-yai.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-s/12/e9/7f/96/santhiya-koh-yao-yai.jpg",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Cox's Bazar",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 1500,
      "description":
          "Cox’s Bazar is a town on the southeast coast of Bangladesh. It’s known for its very long, sandy beachfront, stretching from Sea Beach in the north to Kolatoli Beach in the south. Aggameda Khyang monastery is home to bronze statues and centuries-old Buddhist manuscripts. South of town, the tropical rainforest of Himchari National Park has waterfalls and many birds. North, sea turtles breed on nearby Sonadia Island. \n Area: 23.4 km² \n Weather: 29 °C, Wind W at 8 km/h, 81% Humidity \n\nCox's Bazar Beach (Bengali: কক্সবাজার সমুদ্র সৈকত), located at Cox's Bazar, Bangladesh, is the longest natural sea beach in the world running 120 kilometres (75 mi)[1][2][3][4][5] and 5th longest beach after Praia do Cassino of Brazil, Padre Island on the US Gulf Coast, Eighty Mile Beach in Western Australia, and Ninety Mile Beach of Australia. It is the top tourist destination of Bangladesh. \n\nAt high tide the beach is 200 metres (660 ft) wide and at low tide it is 400 metres (1,300 ft) wide on average. Quicksand is a danger during ebb tide. \n\nKolatoli Point (Bengali: কলাতলী পয়েন্ট) is an important part of Cox's Bazar beach[10] situated near Dolphine intersection of Cox's Bazar city.",
      "images": [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/10/e2/f8/43/longest-sea-beach-in.jpg?w=700&h=-1&s=1",
        "https://1.bp.blogspot.com/-zw3lQgq-v4s/YVsbovs5AwI/AAAAAAAABh8/UuzaqklCG7ICl-OZFHRWpD5ajLs7ZrVXgCLcBGAsYHQ/s1280/Best%2BThings%2BTo%2BDo%2Bin%2BCox%25E2%2580%2599s%2BBazar%2B.png",
        "https://media-cdn.tripadvisor.com/media/photo-s/15/99/54/30/swimming-pool.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/c/cf/Cox%27s_Bazaar_Sunset_Sep2019.jpg",
        "https://cdn.pixabay.com/photo/2018/03/20/14/00/sea-3243357__480.jpg",
        "https://wikitravel.org/upload/shared//thumb/f/fe/Sunsetatcoxsbazar.jpg/400px-Sunsetatcoxsbazar.jpg",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Maui",
      "location": "America",
      "show_location": "South America",
      "price": 9900,
      "description":
          "Maui is an island in the Central Pacific, part of the Hawaiian archipelago. Sprawling Haleakala National Park encompasses the island’s highest peak, volcanic Haleakala, as well as the pools and waterfalls of Ohe’o Gulch, accessed via scenic, winding Hana Highway. The island's 30 miles of beaches include golden-crescent Kapalua, sheltered from strong currents by lava-rock promontories. \n Area: 1,884 km² \n Max length: 64 km \n Max width: 42 km \n Highest elevation: 10,023 ft (3055 m) \n\nMaui, known also as “The Valley Isle,” is the second largest Hawaiian island. The island beloved for its world-famous beaches, the sacred Iao Valley, views of migrating humpback whales (during winter months), farm-to-table cuisine and the magnificent sunrise and sunset from Haleakala. It’s not surprising Maui has been voted 'Best Island in the U.S.' by Condé Nast Traveler readers for more than 20 years. Check out the regions of Maui and all this island has to offer. \n\nWith 120 miles of coastline, Maui boasts over 30 miles of beautiful beaches. On these world famous shores you’ll find white or black sand beaches, renowned surfing and windsurfing spots as well as some of the best beaches in the world to simply swim, snorkel and sunbathe. Many are easily accessible beach parks with lifeguards, picnic facilities and restrooms.",
      "images": [
        "https://www.gohawaii.com/sites/default/files/styles/wide_carousel_large/public/content-carousel-images/10105_mauiregionslp_VideoThumbnail.jpg?itok=vzKj-jK9",
        "https://assets3.thrillist.com/v1/image/2423365/1200x630/flatten;crop_down;webp=auto;jpeg_quality=70",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD0J1JiMs6lXICJOjQu_wmfJxKRXL7Eqi2LrHq6HIAIKVSv-RvL0fzFs1vjcqFLHRcgoc&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWVa-nPuDcZeB_oQXE2-YoRyf672J-1UWoFescMbi_otDmd5MYnmcTIP6m20hY35qA7wA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWHfPkwAI2_zDcJol0L3HDAawDFBHEMVxEfkeuXy2Y3DERPA3G9-ciWlWAR42ZkeEjt_8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgPoIuJPuDTLngaU6voi_POUK0uLluvZwHH9OgxnU6gay3lyq8cn2tSidYE_NDGGQLcFg&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsu9ADS7hIEBIR6rxXS4l0dVXflA4M5RQkGylFjWshkL8L9KcBJiwLUmEHiyDx-sY715U&usqp=CAU",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Miami Beach",
      "location": "Oceania",
      "show_location": "Oceania",
      "price": 4500,
      "description":
          "Miami Beach is a south Florida island city, connected by bridges to mainland Miami. Wide beaches stretch from North Shore Open Space Park, past palm-lined Lummus Park to South Pointe Park. The southern end, South Beach, is known for its international cachet with models and celebrities, and its early-20th-century architecture in the Art Deco Historic district with pastel-colored buildings, especially on Ocean Drive. \n Area: 39.42 km² \n Founded: 26 March 1915 \n Elevation: 1.22 m \n Local time: Friday, 5:44 am \n Weather: 27 °C, Wind E at 2 km/h, 79% Humidity \n\nMiami Beach is a coastal resort city in Miami-Dade County, Florida. It was incorporated on March 26, 1915. The municipality is located on natural and man-made barrier islands between the Atlantic Ocean and Biscayne Bay, the latter of which separates the Beach from the mainland city of Miami. The neighborhood of South Beach, comprising the southernmost 2.5 square miles (6.5 km2) of Miami Beach, along with Downtown Miami and the PortMiami, collectively form the commercial center of South Florida. Miami Beach's population is 82,890 according to the 2020 census. Miami Beach is the 26th largest city in Florida based on official 2019 estimates from the U.S. Census Bureau. It has been one of America's pre-eminent beach resorts since the early 20th century. \n\nIn 1979, Miami Beach's Art Deco Historic District was listed on the National Register of Historic Places.",
      "images": [
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Miamibeach.jpg/800px-Miamibeach.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4PaWwSuTe8DoxX2aHJ4B9w0tef0MK8Y1_o1fxskkCj-rkCG-hBtdKL0xXNHmpMX8p6aA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8LNyqfCdymz7ypzp3L6v9o3-R5y7HotDSw4wGtuBXmSRTdAw0BzMmTdlhplHZwmzJBtk&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM5LUIKFGa89gtpx5pLlm43wcpthw1Oi5KXNFnUYwkai5xNDmfUgDUt5l_1yww64n9jk8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNHVbrgndLJe7UP7NtPeqjirxlgomHMx0C0-9jiFjwbqdmIi-5KF3jFrm5pLHHZXG3enE&usqp=CAU",
        "https://www.worldatlas.com/r/w768/upload/51/df/3a/shutterstock-1341544250.jpg",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/cd/02/3d/caption.jpg?w=500&h=300&s=1&cx=430&cy=826&chk=v1_495186e7d60a7db91378",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Clearwater Beach",
      "location": "America",
      "show_location": "South-East America",
      "price": 7500,
      "description":
          "Laid-back Clearwater Beach is known for its namesake stretch of soft, white sand, which draws visitors year-round for jet-skiing, parasailing, and stand-up paddleboarding in its calm waters. Cyclists and rollerbladers glide along a winding beachfront promenade lined with casual seafood restaurants and cafes. Come sunset, Pier 60 hosts a nightly festival with street performers and craft vendors. \n Elevation: 9 m \n\nLaid-back Clearwater Beach is known for its namesake stretch of soft, white sand, which draws visitors year-round for jet-skiing, parasailing, and stand-up paddleboarding in its calm waters. Cyclists and rollerbladers glide along a winding beachfront promenade lined with casual seafood restaurants and cafes. Come sunset, Pier 60 hosts a nightly festival with street performers and craft vendors. \n\nIn addition to its countless beach accolades, Clearwater ranked #6 on Tripadvisor's list of “Top Trending Destinations in the U.S.” for 2022. The gorgeous white sands and sparkling waters of Clearwater Beach also made Travel + Leisure's list of 'The 14 Best Beaches in Florida' in 2021. \n\nStretching roughly 3 miles long and three blocks wide, Clearwater Beach draws about 4 million visitors a year — making what the Tampa Bay Times dubbed 'the Disney World of beaches' one of the top tourist destinations along the Gulf Coast.",
      "images": [
        "https://images.musement.com/cover/0156/24/clearwater-beach-adobestock-431618946-jpeg_header-15523519.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjZBK86YM7ZEEY0Wy8QbU3ooDwwkMtvkpbt4jFf76sAosaahWE9W0Z25sADM4VSEUCbb4&usqp=CAU",
        "https://a.cdn-hotels.com/gdcs/production177/d1249/a5ff4ac9-f813-4ecb-8dc6-59961f521979.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBTuBG__swAQbx46buHm0QYKmJ5PcSjze1gNdoXePdEw4Ud6ohbaQDiwpTHVXDGXOR-_c&usqp=CAU",
        "https://alwaysontheshore.com/wp-content/uploads/2021/01/090.jpg",
        "https://webbox.imgix.net/images/rgywmmdnxbrfmdms/fe480232-db0c-493f-8e8d-f21f542a49d7.jpg?auto=format,compress&fit=crop&crop=entropy",
        "https://live.staticflickr.com/7451/13139518484_a0cb5d9db6_b.jpg",
        "https://www.83degreesmedia.com/galleries/pier_60_by_james_branaman.jpeg",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Santa Monica State",
      "location": "Oceania",
      "show_location": "Oceania",
      "price": 1700,
      "description":
          "Santa Monica State Beach is a California State Park operated by the city of Santa Monica. \n Management: California State Parks \n\nSanta Monica (Spanish for 'Saint Monica') is a beachfront city in western Los Angeles County, California, United States. Situated on Santa Monica Bay, it is bordered on five sides by different neighborhoods of the city of Los Angeles: Pacific Palisades to the north, Brentwood on the northeast, West Los Angeles on the east, Mar Vista on the southeast, and Venice on the south. The 2020 U.S. Census population of Santa Monica was 93,076. Due to its favorable climate and proximity to Los Angeles, Santa Monica became a resort town by the early 20th century, attracting celebrities such as Marion Davies to build magnificent beach front homes on Pacific Coast Highway (PCH). \n\nThe city has experienced a boom since the late 1980s, through the revitalization of its downtown core, significant job growth, and increased tourism. Popular tourists sites include Pacific Park on the Santa Monica Pier and Palisades Park atop a bluff over the Pacific Ocean. \n\nAs in other coastal beach communities, coastal erosion, due to coastal infrastructure and high human usage, is an increasing challenge, and will become worse due to sea level rise. Santa Monica has a history of developing environmental and sustainability strategies, with the most recent focus on community-wide carbon neutrality by 2050 or sooner.",
      "images": [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/41/76/79/caption.jpg?w=1200&h=-1&s=1",
        "https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/27/60/26.jpg",
        "https://d323urej3s5qb3.cloudfront.net/thehuntleyhotel.com-2772596881/cms/cache/v2/56412c1545930.jpg/1272x756/fit/80/2a1ac3e213e7039c8756da58a33154a6.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhb1JBvrYPH701BeXIzEwFqNBnuPqm5qWH-BI92nriJTWFtz2Lq6hVPbmR_FYp5Ptfuc&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVOi92JAG0myHqoh0bHM3DwNuJ1nXRy8RdwSMMunfP_n1wMvIdv5Dy9jz8dboKEnhx7Xc&usqp=CAU",
        "https://media.cntraveler.com/photos/5a8db36a723a834885e1527b/16:9/w_2560,c_limit/Santa-Monica-State-Beach_GettyImages-579739546.jpg",
        "https://a.cdn-hotels.com/gdcs/production14/d1087/59523f11-21cb-4a60-8d14-c61ccac2da6e.jpg?impolicy=fcrop&w=800&h=533&q=medium",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Bondi Beach",
      "location": "Europe",
      "show_location": "Europe",
      "price": 5000,
      "description":
          "The sweeping white-sand crescent of Bondi is one of Australia’s most iconic beaches. Reliable waves draw surfers while, nearby, hardy locals swim in the Icebergs ocean pool year-round. Trendy, health-conscious Sydneysiders head to laid-back cafes around Hall Street, while hip backpackers frequent the area's casual pubs. Walkers and joggers use the clifftop Bondi to Coogee Coastal Walk, with its dramatic scenery. \n Area: 122 ha \n Elevation: 21 m \n Location: 7 km (4 mi) E of Sydney CBD \n\nThe sweeping white-sand crescent of Bondi is one of Australia’s most iconic beaches. Reliable waves draw surfers while, nearby, hardy locals swim in the Icebergs ocean pool year-round. Trendy, health-conscious Sydneysiders head to laid-back cafes around Hall Street, while hip backpackers frequent the area's casual pubs. Walkers and joggers use the clifftop Bondi to Coogee Coastal Walk, with its dramatic scenery. \n\nBondi Beach entry is free of cost. There is no entry fee charged for visiting Bondi Beach. You can visit this immensely pretty beach without any charges and have a relaxing and wonderful time by the water here. \n\nA local dive site known as the Bondi Boulders in North Bondi contains plenty of marine life, including baby Port Jackson sharks, scorpion fish, crabs and sea stars. It features giant pink boulders with trademark holes burrowed out by generations of black sea urchins.",
      "images": [
        "https://afar.brightspotcdn.com/dims4/default/8a609b6/2147483647/strip/true/crop/728x500+36+0/resize/660x453!/quality/90/?url=https%3A%2F%2Fafar-media-production-web.s3.amazonaws.com%2Fbrightspot%2F96%2F3a%2F0f782777468afd020670bb4894f6%2Foriginal-eb4929423cf53b1d3e55b02c14d7bd73.jpg",
        "https://int.sydney.com/sites/international/files/styles/header_slider/public/2016-12/Bondi-Beach-Sunrise-DNSW.jpg?itok=2Xl-k7Kz",
        "https://www.travellens.co/content/images/2020/08/bondi-beach.jpg",
        "https://media.destinationnsw.com.au/sites/default/files/lookatmedam/147815l3.jpg",
        "https://preview.redd.it/4wrprmq0wlr81.jpg?width=480&format=pjpg&auto=webp&s=c1728474da14613a19c719ba5a148a8b225738f9",
        "https://cdn.pixabay.com/photo/2021/04/06/19/40/bondi-beach-6157295_960_720.jpg",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Byron Bay",
      "location": "Europe",
      "show_location": "Europe",
      "price": 9500,
      "description":
          "Byron Bay is a coastal town in the southeastern Australian state of New South Wales. It’s a popular holiday destination, known for its beaches, surfing and scuba diving sites. Cape Byron State Conservation Park is on a headland with a lighthouse. Between June and November, humpback whales can be spotted from headland viewpoints such as the Captain Cook Lookout. \n Elevation: 1 m \n Area: 12,406 km² \n Weather: 17 °C, Wind E at 8 km/h, 94% Humidity \n\nVisitors enjoy a variety of accommodation options, some of the best food and food producers in the country, a wide range of activities, inspirational brands, fantastic markets and more. Byron Bay truly is unlike anywhere in the world. So, come visit the wellness capital of Australia and experience the awe- inspiring natural beauty, and lively, welcoming community. \n\nExplore the region’s beaches by kayak, on horseback, by taking surf lessons, or whale watching. Get a birds-eye-view of the mountains and coastal landscape by balloon, or cross sky-diving off your bucket list. Shop local designers and producers at the community markets, be the first in Australia to watch the sunrise, or treat yourself to an indulgent day at the spa.Hike to the iconic lighthouse, people-watch with a cup of coffee, or discover the local art scene at one of Byron’s galleries or live music venues.",
      "images": [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/34/00/72/byron-bay.jpg?w=700&h=500&s=1",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG9h_hc1tb33Wl6boOsIavATyLWDgXM4H7fYwBTHVO9IlN-qTtEjek2NG4w7Hdz3sjNQw&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgHQb_9I-3N7x3Re4F9W56T-ZbPoYJOZ14ySH4e8hiflwHZaBxbOybfMAC1eYEP9eq3I8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXOvOE12855tFSFEpAHVxFv-Ar2T_dI-tcN3esYz-ulI3bohGmNiOiMYHpn0QtZ7fYYbQ&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsAGgVL6zbmOu4c-fyjkbd0dA8gpgjGA7ks7lg4FbS6taW8wPOH2O7cqoUVBMTRHKFaYQ&usqp=CAU",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Guru Shikhar",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 9500,
      "description":
          "Guru Shikhar, a peak in the Arbuda Mountains of Sirohi district in Rajasthan, is the highest point of the Aravalli Range and Rajasthan. It rises to an elevation of 1,722 metres. \n Elevation: 1,722 m \n Prominence: 1,341 m \n District: Sirohi district \n\nGuru Shikhar, a peak in the Arbuda Mountains of Sirohi district in Rajasthan, is the highest point of the Aravalli Range and Rajasthan. It rises to an elevation of 1,722 metres (5,650 ft). It is 75 km from Sirohi city, the district headquarter and 15 km from Mount Abu and a road from there leads almost to the top of the mountain. It is named Guru-Shikhar or 'the peak of the guru' after Dattatreya, an incarnation of Vishnu, andof a cave at the summit contains a temple dedicated to him, plus one edicated his mother, Anasuya, wife of sage Atri nearby. \n\n Adjacent to the temple is the Mt Abu Observatory operated by the Physical Research Laboratory. This observatory hosts a 1.2m infrared telescope and also several Astronomy experiments",
      "images": [
        "https://www.trawell.in/admin/images/upload/169351146Mount_Abu_Guru_Shikhar_Main.jpg",
        "https://www.abutimes.com/wp-content/uploads/2015/12/gushikar-mount-abu.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/8/8a/Arbuda_Mountains.JPG",
        "https://www.tourmyindia.com/images/guru-shikhar1.jpg",
        "https://mountabu.tourismindia.co.in/images/places-to-visit/header/guru-shikhar-mount-abu-tourism-entry-fee-timings-holidays-reviews-header.jpg",
        "https://www.hummingbirdresorts.com/assets/images/blog/blog7-1.jpg",
        "https://www.transindiatravels.com/wp-content/uploads/guru-shikhar-1.jpg",
      ],
      "category": "Mountain",
      "isRecommended": false
    },
    {
      "name": "Mount Taranaki",
      "location": "Europe",
      "show_location": "South Europe",
      "price": 6800,
      "description":
          "Mount Taranaki, less commonly known as Mount Egmont, is a dormant stratovolcano in the Taranaki region on the west coast of New Zealand's North Island. It is the second highest point in the North Island, after Mount Ruapehu. The 2,518-metre mountain has a secondary cone, Fanthams Peak, 1,966 metres, on its south side. \n Elevation: 2,518 m \n Prominence: 2,308 m \n First ascent: 1839 \n Last eruption: 1854 \n\nThe name Taranaki comes from the Māori language. The Māori word tara means mountain peak, and naki is thought to come from ngaki, meaning 'shining', a reference to the snow-clad winter nature of the upper slopes. It was also named Pukehaupapa and Pukeonaki by iwi who lived in the region in 'ancient times'. \n\nCaptain Cook named it Mount Egmont on 11 January 1770 after John Perceval, 2nd Earl of Egmont, a former First Lord of the Admiralty who had supported the concept of an oceanic search for Terra Australis Incognita. Cook described it as 'of a prodigious height and its top cover'd with everlasting snow,' surrounded by a 'flat country ... which afforded a very good aspect, being clothed with wood and verdure'.",
      "images": [
        "https://upload.wikimedia.org/wikipedia/commons/b/b7/Mt_Taranaki.JPG",
        "https://media.istockphoto.com/photos/view-of-mt-taranaki-new-zealand-picture-id1190530530?b=1&k=20&m=1190530530&s=170667a&w=0&h=e9FiJWMlNW3NntBFmkXiAilb3hPp_OfE3OEBLDwwaLo=",
        "https://www.discoverimages.com/p/251/mount-taranaki-egmont-taranaki-north-island-19446541.jpg",
        "https://volcano.si.edu/gallery/photos/GVP-00337.jpg",
        "https://i.guim.co.uk/img/media/ab885a519909f8d701dcd767f3817740b762df37/0_266_2000_1200/master/2000.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=2207d81765aba0a920e7065f1bb3ad22",
        "https://thumbs.dreamstime.com/b/mt-taranaki-farm-land-5099188.jpg",
      ],
      "category": "Mountain",
      "isRecommended": false
    },
    {
      "name": "Grand Teton",
      "location": "America",
      "show_location": "South America",
      "price": 9500,
      "description":
          "The Teton Range is a mountain range of the Rocky Mountains in North America. It extends for approximately 40 miles in a north–south direction through the U.S. state of Wyoming, east of the Idaho state line. \n Elevation: 4,199 m \n Area: 3,341 km² \n Highest point: Grand Teton \n Mountain range: Rocky Mountains \n\nAlong with surrounding national forests, these three protected areas constitute the almost 18-million-acre (73,000-square-kilometer) Greater Yellowstone Ecosystem, one of the world's largest intact mid-latitude temperate ecosystems. \n\nThe human history of the Grand Teton region dates back at least 11,000 years when the first nomadic hunter-gatherer Paleo-Indians began migrating into the region during warmer months to pursue food and supplies. In the early 19th century, the first white explorers encountered the eastern Shoshone natives. Between 1810 and 1840, the region attracted fur trading companies that vied for control of the lucrative beaver pelt trade. U.S. Government expeditions to the region commenced in the mid-19th century as an offshoot of exploration in Yellowstone, with the first permanent white settlers in Jackson Hole arriving in the 1880s.",
      "images": [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/04/cc/c9/fc/grand-teton.jpg?w=1200&h=-1&s=1",
        "https://lp-cms-production.imgix.net/2019-06/8e10686bea7685a55b4145d732a9a48a906c5cd1f3e6b9ebb4ca4c5b74e3946f.jpg?sharp=10&vib=20&w=1200&auto=compress&fit=crop&fm=auto&h=800",
        "https://www.getyourguide.com/magazine/wp-content/migrated-content/uploads/2021/03/TC21-MAG-TETYELL-001-1200x900.jpg",
        "https://i.ytimg.com/vi/GXZEXHZT4LM/maxresdefault.jpg",
        "https://imengine.prod.srp.navigacloud.com/?uuid=161a5b21-66a6-5810-9d16-23839fc22a76&type=primary&q=72&width=1000",
        "https://www.tripsavvy.com/thmb/XpEGcflbLCWCH_NUTnPkC7lfccI=/2700x1800/filters:fill(auto,1)/DSCF9428-043df156e4af41ffbf56bfa1033a0035.jpg",
      ],
      "category": "Mountain",
      "isRecommended": false
    },
    {
      "name": "Denali",
      "location": "America",
      "show_location": "North America",
      "price": 7000,
      "description":
          "Denali is the highest mountain peak in North America, with a summit elevation of 20,310 feet above sea level. With a topographic prominence of 20,194 feet and a topographic isolation of 4,621.1 miles, Denali is the third most prominent and third most isolated peak on Earth, after Mount Everest and Aconcagua. \n Elevation: 6,190 m \n Prominence: 6,144 m \n First ascent: 7 June 1913 \n\nThe Koyukon people who inhabit the area around the mountain have referred to the peak as 'Denali' for centuries. In 1896, a gold prospector named it 'Mount McKinley' in support of then-presidential candidate William McKinley; that name was the official name recognized by the federal government of the United States from 1917 until 2015. In August 2015, 40 years after Alaska had done so, the United States Department of the Interior announced the change of the official name of the mountain to Denali. \n\nIn 1903, James Wickersham recorded the first attempt at climbing Denali, which was unsuccessful. In 1906, Frederick Cook claimed the first ascent, but this ascent is unverified and its legitimacy questioned. ",
      "images": [
        "https://upload.wikimedia.org/wikipedia/commons/9/91/Wonder_Lake_and_Denali.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcSZ0aoRVUkm9cO0FHDs67KpnvEqR9In4MbQx4xKH6tk4IcLb8HXFKVPhr5jaBapcc-v4&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpDKabqbm5yPJL0RT0RpIgq1wqbzpLFmGcuRbtPUZGjapDK0Gqvvk2DtRUqedo7v4KMd0&usqp=CAU",
        "https://res.cloudinary.com/dtpgi0zck/image/upload/s--5Pb3YX9z--/c_fill,h_580,w_860/v1/EducationHub/photos/mount-denali-cloud.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeEsZQql6i7OBdGUVr2xm9PLQiKRi7GEXsvIdfPwzhrinawYruPjgnevyFEABCIkvkEUE&usqp=CAU",
        "https://www.nps.gov/dena/learn/historyculture/images/denali.jpg?maxwidth=1200&autorotate=false",
      ],
      "category": "Mountain",
      "isRecommended": false
    },
    {
      "name": "Shkhara",
      "location": "Oceania",
      "show_location": "Oceania",
      "price": 8100,
      "description":
          "Shkhara is the highest point in the nation of Georgia It is located near the Russian-Georgian border, in Russia's Kabardino-Balkaria region on the northern side, and the Svaneti region of Georgia in the south.\n Elevation: 5,193 m \n First ascent: 1888 \n Prominence: 1,357 m \n\nShkhara is the high point and the eastern anchor of a massif known as the Bezingi (or Bezengi) Wall, a 12-kilometre-long (7.5 mi) ridge. It is a large, steep peak in a heavily glaciated region, and presents serious challenges to mountaineers. Its north face (on the Russian side) is 1,500 metres (4,900 ft) high and contains several classic difficult routes. The significant sub-summit Shkhara West, at 5,068 m (16,627 ft), is a climbing objective in its own right, and a traverse of the entire Bezingi Wall is considered 'Europe's longest, most arduous, and most committing expedition'.",
      "images": [
        "https://i.ytimg.com/vi/OC2j7j4Qazs/maxresdefault.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKM7tSImwANa25jhzjBjSeZOYAepe4QiTgJA&usqp=CAU",
        "https://alexclimb.com/_data/cat/157/IMG_3156.jpg",
        "https://image.shutterstock.com/image-photo/ushguli-village-near-highest-georgian-260nw-2194124103.jpg",
        "https://st.focusedcollection.com/13397678/i/1800/focused_180916940-stock-photo-view-wildflower-meadow-shkhara-mountain.jpg",
      ],
      "category": "Mountain",
      "isRecommended": false
    },
    {
      "name": "Rainbow Mountain",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 9300,
      "description":
          "Vinicunca, or Winikunka, also called Montaña de Siete Colores, Montaña de Colores or Rainbow Mountain, is a mountain in the Andes of Peru with an altitude of 5,200 metres above sea level. \n Elevation: 5,200 m \n Location: Peru \n Mountain range: Andes \n\nTourist access requires a two-hour drive from Cusco and a walk of about 5 kilometers (3.1 mi), or a three-and-a-half-hour drive through Pitumarca and a one-half-kilometre (0.31 mi) steep walk (1–1.5 hours) to the hill. As of 2019, no robust methods of transportation to Vinicunca have been developed to accommodate travelers, as it requires passage through a valley. \n\nIn mid-2010, mass tourism came, attracted by the mountain's series of stripes of various colors due to its mineralogical composition on the slopes and summits. The mountain used to be covered by glacier caps, but these have melted due to climate change approximately 10,000 years ago. \n\nVinicunca is located to the southeast of the city of Cusco and can be reached from Cusco via two routes: Cusipata or Pitumarca. One route is through the Peruvian Sierra del Sur (PE-3s) in the direction of the town of Checacupe, and further to the town of Pitumarca, which is around two hours from the city of Cusco.",
      "images": [
        "https://image.cnbcfm.com/api/v1/image/106203306-1571991790927gettyimages-1095321688cropped.jpg?v=1571991897",
        "https://cdn.kimkim.com/files/a/content_articles/featured_photos/ea1db64e3b4cdca9158dbbc40fbd8f9ff0a39abf/big-e557183034d6ae13a8d949a915953061.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTv6Hk2BpXqhYlUWBfbJKm6EoVQDc-GKdA9MNdbPxZZfo-0dyAku2fRjtnlvdL9_w6JmiA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjT49epe37Q_P7Ny3acqZC42IMA-Q9AAs_SQS-J_Uhzg_g3F0TX_aH_wJEeTt1Bt2XEBs&usqp=CAU",
        "https://www.tierrasvivas.com/img/rainbow-mountains-in-cusco-195.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVbhkwh6huVf67r1N35TsgTrqQyi_sstE8fYiwoy-8U28oRNarBJKALFqD7mCBZD8uMw4&usqp=CAU",
      ],
      "category": "Mountain",
      "isRecommended": false
    },
    {
      "name": "Anamudi",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 1300,
      "description":
          "Anamudi is a mountain located in Ernakulam district and Idukki district of the Indian state of Kerala. It is the highest peak in the Western Ghats and in South India, at an elevation of 2,695 metres and a topographic prominence of 2,479 metres. \n Elevation: 2,695 m \n First ascent: 4 May 1862 \n Prominence: 2,479 m \n\nThe name Anamudi literally translates to 'elephant's head' a reference to the resemblance of the mountain to an elephant's head. Anamudi is the highest mountain in peninsular India as well as the largest mountain in Kerala. Meanwhile, the highest independent mountain ( free-standing mountain ) in Kerala is the Cheriyam mountain in Malappuram district. Cheriyam mountain is located at an elevation of 613 m (2,011 ft) above sea level. \n\nThe first recorded ascent of Anamudi was by General Douglas Hamilton of the Madras Army on 4 May 1862,[citation needed] but it is likely that there had been earlier ascents by local people. \n\nAnamudi peak is one of only three ultra prominent peaks in South India. It is also the peak with the greatest topographic isolation within India. It is the highest point in India south of Himalayas. Thus it is known as 'Everest of South India'. The peak is not exceptionally dramatic in term of steepness or local relief and is a fault-block mountain. ",
      "images": [
        "https://www.oyorooms.com/travel-guide/wp-content/uploads/2020/01/Anamudi-View-Point-1.jpg",
        "https://www.accessindiatourism.com/wp-content/uploads/2022/03/Anamudi-Peak-Banner-2.jpg",
        "https://www.munnar.holiday/munnartourism/wp-content/uploads/2019/06/anamudi-peak-munnar-kerala-1024x385.jpg",
        "https://a0.muscache.com/im/pictures/3f524723-b711-45e0-b75e-a1b66283da14.jpg?im_w=720",
        "https://media.tripinvites.com/places/munnar/chokramudi-peak/chokramudi-peak-featured.jpg",
      ],
      "category": "Mountain",
      "isRecommended": false
    },
    {
      "name": "Sumantri",
      "location": "Oceania",
      "show_location": "Oceania",
      "price": 7500,
      "description":
          "Sumantri Peak is a sharp mountain in the western Sudirman Range. It rises 4,870 metres. The peak is approximately 2 km northeast of Carstensz Pyramid, the highest mountain of Oceania. \n Elevation: 4,870 m \n Prominence: 350 m \n First ascent: 1962 \n\nThe mountains of Central Papua are being formed as the Australian and Pacific Plates collide, resulting in both subduction and uplifting. The rocks at the surface for the peaks in this range are made of limestone. As a result, even though the summit block of the peak looks extremely daunting, it is a fairly easy scramble. \n\nThe Indonesian government renamed the NW summit after professor Sumantri Brodjonegoro [id], Minister of Energy and Mineral Resources of the Republic of Indonesia, after he had died in office in 1973 at the age of 47. \n\nThe 600 m high north cliff was first climbed by Reinhold Messner in a solo effort on 27 September 1971, after he had second-ascended the Carstensz Pyramid with his client Sergio Bigarella earlier in the week. A year later Leo Murray, Jack Baines, and Dick Isherwood climbed both peaks of Ngga Pulu and found the peg that Meisner had left behind on top of the North Face of what they called Ngga Poloe (now Sumantri).",
      "images": [
        "https://upload.wikimedia.org/wikipedia/commons/5/5d/Sumantri_%28center%29_with_Ngga_Pulu_%28right%29_from_Carstensz_Summit_by_Christian_Stangl_flickr.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTjJ49z4imoCA6HN5FoqLvXr-rUsAD2ZgCAAXad-P_COvfKH8E7bJ-lse8bZ83FIxnaug&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmWmo9cOlx6Td17DfWxpP4Q11niz0YQjscVjuEW9dzhFZ7nVYwyD7akIzNdfmL7t43cnc&usqp=CAU",
        "https://buliran.com/wp-content/uploads/2021/10/11.-1-sumantri-250x150.jpg",
        "https://www.ispo.com/sites/default/files/styles/teaser_desktop/public/2021-09/Ngga-Pulu.jpeg?h=c673cd1c&itok=JriRyjFx",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Puncak_Jaya_icecap_1972.jpg/650px-Mapcarta.jpg",
      ],
      "category": "Mountain",
      "isRecommended": false
    },
    {
      "name": "Aoraki / Mount Cook",
      "location": "Europe",
      "show_location": "Europe",
      "price": 10000,
      "description":
          "Aoraki / Mount Cook is the highest mountain in New Zealand. Its height, as of 2014, is listed as 3,724 metres. It sits in the Southern Alps, the mountain range that runs the length of the South Island. A popular tourist destination, it is also a favourite challenge for mountain climbers. \n Elevation: 3,724 m \n First ascent: 25 \n December 1894 \n Prominence: 3,724 m \n\nThe mountain is in the Aoraki / Mount Cook National Park, in the Canterbury Region. The park was established in 1953 and along with Westland National Park, Mount Aspiring National Park and Fiordland National Park forms one of the UNESCO World Heritage Sites. The park contains more than 140 peaks standing over 2,000 metres (6,600 ft) and 72 named glaciers, which cover 40 percent of its 700 square kilometres (170,000 acres). \n\nThe peak is located at the northern end of the Kirikirikatata / Mount Cook Range, where it meets with the main spine of the Main Divide, forming a massif between the Hooker Valley to the southwest and the Tasman Valley east of the mountain. These two valleys provide the closest easily accessible view points of Aoraki / Mount Cook. A lookout point at the end of the Hooker Valley Track located only 10 km from the peak has views of the entire mountainside. \n\nThe settlement of Mount Cook Village, also referred to as 'Aoraki / Mount Cook', is a tourist centre and base camp for the mountain.",
      "images": [
        "https://www.newzealand.com/assets/Tourism-NZ/Christchurch-Canterbury/9aa11093e3/img-1536989144-436-6533-p-4AE01862-F0F6-45CC-A4A8B61D309D3D12-2544003__aWxvdmVrZWxseQo_FocalPointCropWzM1MiwxMDI0LDUzLDUwLDc1LCJqcGciLDY1LDIuNV0.jpg",
        "https://img.freepik.com/premium-photo/aoraki-mount-cook-reflected-hooker-ake-with-iceberg-aoraki-mount-cook-national-park_461746-85.jpg?w=2000",
        "https://static.horizonguides.com/images/_matrixImage/Aoraki-Mt-Cook-national-park_mt-cook-reflected-in-a-tarn.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-s/1a/65/1e/13/caption.jpg",
        "https://live.staticflickr.com/8464/8114772965_2fd1979e70_b.jpg",
      ],
      "category": "Mountain",
      "isRecommended": false
    },
    {
      "name": "Taj Mahal",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 8500,
      "description":
          "The Taj Mahal, is an Islamic ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra. It was commissioned in 1632 by the Mughal emperor Shah Jahan to house the tomb of his favourite wife, Mumtaz Mahal; it also houses the tomb of Shah Jahan himself. \n Construction started: 1632 \n Height: 73 m \n Architectural style: Mughal architecture \n\nConstruction of the mausoleum was essentially completed in 1643, but work continued on other phases of the project for another 10 years. The Taj Mahal complex is believed to have been completed in its entirety in 1653 at a cost estimated at the time to be around ₹32 million, which in 2020 would be approximately ₹70 billion (about US \$1 billion). The construction project employed some 20,000 artisans under the guidance of a board of architects led by the court architect to the emperor, Ustad Ahmad Lahauri. Various types of symbolism have been employed in the Taj to reflect natural beauty and divinity. \n\nThe Taj Mahal was designated as a UNESCO World Heritage Site in 1983 for being 'the jewel of Muslim art in India and one of the universally admired masterpieces of the world's heritage'.",
      "images": [
        "https://images.unsplash.com/photo-1564507592333-c60657eea523?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dGFqJTIwbWFoYWx8ZW58MHx8MHx8&w=1000&q=80",
        "https://miro.medium.com/max/1400/1*R9K4HFA1aG6Skyfs3Ox7bw.jpeg",
        "https://lp-cms-production.imgix.net/2019-06/283389.jpg",
        "https://images.livemint.com/img/2022/08/04/1600x900/Taj-Mahal-sylwia-bartyzel-eU4pipU_8HA-unsplash_1659578942151_1659578950109_1659578950109.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1mzOna-042vBgWAFodNBC95wQ_QhJdRk79g&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG8v0QxONh_IDrFYLH72_KGQi_oko5T2FMJQ&usqp=CAU",
        "https://vid.alarabiya.net/images/2018/07/19/8c13bb26-4552-4030-a34e-11341f2281c1/8c13bb26-4552-4030-a34e-11341f2281c1.jpg?crop=4:3&width=1200",
      ],
      "category": "History",
      "isRecommended": false
    },
    {
      "name": "Angkor Wat",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 7980,
      "description":
          "Angkor Wat is a temple complex in Cambodia and is the largest religious monument in the world, on a site measuring 162.6 hectares. \n Address: Krong Siem Reap, Cambodia \n Land area: 163 ha \n Architectural styles: Khmer (Angkor Wat style) \n\nAngkor Wat was built by the Khmer King Suryavarman II[5] in the early 12th century in Yaśodharapura (Khmer: យសោធរបុរៈ, present-day Angkor), the capital of the Khmer Empire, as his state temple and eventual mausoleum. Angkor Wat combines two basic plans of Khmer temple architecture: the temple-mountain and the later galleried temple. It is designed to represent Mount Meru, home of the devas in Hindu mythology: within a moat more than 5 kilometres (3 mi) long[6] and an outer wall 3.6 kilometres (2.2 mi) long are three rectangular galleries, each raised above the next. At the centre of the temple stands a quincunx of towers. Unlike most Angkorian temples, Angkor Wat is oriented to the west; scholars are divided as to the significance of this. The temple is admired for the grandeur and harmony of the architecture, its extensive bas-reliefs, and for the numerous devatas adorning its walls.",
      "images": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6KE4yDZbLsxdw2HE-ixV3ngHYjrZ6wjgJIqPGmWj1KJyFI-TSNMyYz1WNJFbxTLRZm-M&usqp=CAU",
        "https://i.natgeofe.com/n/ecc4af4e-7bd2-40cc-a854-62ca89d7f96b/93405.jpg?w=636&h=425",
        "https://www.lifeberrys.com/img/article/angkor-1490162835-lb.jpg",
        "https://cdn.slidesharecdn.com/ss_thumbnails/angkorwat-120604103326-phpapp01-thumbnail-4.jpg?cb=1659448889",
        "https://images.squarespace-cdn.com/content/v1/5a9df9f4a9e028af26f1eb8c/a3c79a3f-e14b-4072-b5ab-630709b58746/angkor-wat-one-day-angkor-wat-itinerary-siem-reap-one-day-1.jpg?format=1000w",
        "https://res.klook.com/image/upload/c_fill,w_750,h_500,f_auto/w_80,x_15,y_15,g_south_west,l_Klook_water_br_trans_yhcmh3/activities/oaxmwqkrbp6epksjve40.jpg",
      ],
      "category": "History",
      "isRecommended": false
    },
    {
      "name": "Hawa Mahal",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 6610,
      "description":
          "The Hawa Mahal is a palace in the city of Jaipur, India. Built from red and pink sandstone, it is on the edge of the City Palace, Jaipur, and extends to the Zenana, or women's chambers. \n Architectural styles: Mughal architecture, Rajput architecture \n Opened: 1799 \n Height: 15 m \n Floors: 5 \n\nIt was designed by Lal Chand Ustad. Its five-floor exterior is akin to a honeycomb with its 953 small windows called Jharokhas decorated with intricate latticework. The original intent of the lattice design was to allow royal ladies to observe everyday life and festivals celebrated in the street below without being seen, since they had to obey the strict rules of 'purdah', which forbade them to appear in public without face coverings. This architectural feature also allowed cool air from the Venturi effect to pass through, thus making the whole area more pleasant during the high temperatures in summer. Many people see the Hawa Mahal from the street view and think it is the front of the palace, but it is the back. \n\nIn 2006, renovation works on the Mahal were undertaken, after a gap of 50 years, to give a facelift to the monument at an estimated cost of Rs 4.568  million.",
      "images": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfcdf4uL_AkihW1r2J3kPv6x7k7toSk_q1w7l3G-I2MYlLrrr_djnqPSsZAkIJX2ncNtU&usqp=CAU",
        "https://img.onmanorama.com/content/dam/mm/en/travel/travel-news/images/2020/2/6/hawa-mahal-jaipur.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxfHBdEVWVbfQFD_tSFPOHaANzx4ZDXXbDV6ZiebJyEXxFUXabJHQMbu4sWXc4kysZ-hw&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg3vf66VrtBizI4069zZbJgZ7tKlCxA_GXhg6T_6biMF8wqDBL8bNiZ25HoyYFwi-_TyA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRguXxMKsOBaxmWzas4p4FSssxt68C4mzNVWtzwHIUaAwG665-qxsigZwfbq0ey0RRIx-o&usqp=CAU",
        "https://cdn.theculturetrip.com/wp-content/uploads/2016/06/1024px-hawa_mahal_final_1.jpg",
      ],
      "category": "History",
      "isRecommended": false
    },
    {
      "name": "Mysore Palace",
      "location": "Oceania",
      "show_location": "Oceania",
      "price": 4700,
      "description":
          "The Mysore Palace, also known as Amba Vilas Palace, is a historical palace and a royal residence. It is located in Mysore, Karnataka. It used to be the official residence of the Wadiyar dynasty and the seat of the Kingdom of Mysore. The palace is in the centre of Mysore, and faces the Chamundi Hills eastward. \n Construction started: 1897 \n Architectural style: Indo-Saracenic architecture \n Opened: 1912 \n\nThe palace is in the centre of Mysore, and faces the Chamundi Hills eastward. Mysore is commonly described as the 'City of Palaces', and there are seven palaces including this one. However, the Mysore Palace refers specifically to the one within the new fort. \n\nThe land on which the palace now stands was originally known as mysuru (literally, 'citadel'). Yaduraya built the first palace inside the Old Fort in the 14th century, which was set ablaze and reconstructed multiple times. The Old Fort was built of wood and thus easily caught fire, while the current fort was built of stone, bricks and wood. The current structure was constructed between 1897 and 1912, after the Old Palace burnt down, the current structure is also known as the New Fort. Mysore Palace is one of the most famous tourist attractions in India, after the Taj Mahal, with more than six million annual visitors.",
      "images": [
        "https://upload.wikimedia.org/wikipedia/commons/a/a4/Mysore_Palace_Morning.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCemz0NuWvQW32PVYZtlxyP7J-dIPPM4rahmWXFxIcUeYoGkfui0Fyv27vrFtCw97qsb8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBeAcim03zD43hsH6Lb2_KkgDZKQB5Mnkyk5IlAQ2qNVAvg8X8sLTsX2Sy13ZX5-KOhG0&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl6k1a558aa4tHO-CEGmbL6iu9w4z8CnQhDttEyOwaZr7VIGiGd6qGMoOjBOZxM1eEFn8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgVOetgSNr1EuUlGKiga_hpSmMi58HDXdz6h2kJZIJhPPDYj3Iu60MeBG-EODwH9TkIP8&usqp=CAU",
        "https://www.holidify.com/images/cmsuploads/compressed/attr_1568_20191102174918.jpg",
      ],
      "category": "History",
      "isRecommended": false
    },
    {
      "name": "Kumbhalgarh Fort",
      "location": "Europe",
      "show_location": "Europe",
      "price": 11200,
      "description":
          "Kumbhalgarh also known as the Great Wall of India is a Mewar fortress on the westerly range of Aravalli Hills, just about 48 km from Rajsamand city in the Rajsamand district of the Rajasthan state in western India. It is located about 84 km from Udaipur. It is a World Heritage Site included in Hill Forts of Rajasthan. \n Opened: 1592 \n Function: Fortification \n Area: 268 ha (1.03 sq mi) (662 acres) \n\nKumbhalgarh, as the fort we see it was built by Rana Kumbha who was the Rana of Mewar from the Sisodia rajput clan. Rana Kumbha took the aid of the famous architect of the era, 'Mandan'. \n\nAaret Pol was the first entry gate of the fort. Halla Pol is on the downward slope from the entrance. Just after Halla Pol is Badshahi Bavdi, a stepped tank, built after the invasion of Shahbaz Khan in 1578, the general of Mughal emperor Akbar to provide water to the troops. \n\nHanuman Pol, the next gate is half a KM away from Halla Pol. Hanuman Pol is a double-storeyed gate with octagonal bastions. The gate got its name from the stone image of Hanuman located in front of the gate, which was brought by Maharana Kumbha.",
      "images": [
        "https://www.tripsavvy.com/thmb/WTeNf6nzcS1x7sj704RCRBV669U=/2119x1415/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-186361655-5c1b7361c9e77c00019049d3.jpg",
        "https://images.thrillophilia.com/image/upload/s--NNVLEohB--/c_fill,h_600,q_auto,w_975/f_auto,fl_strip_profile/v1/images/photos/000/356/454/original/1601712791_Udaipur-india-shutterstock_753879010.jpg.jpg?1601712791",
        "https://pbs.twimg.com/media/E6gS7L2VUAAASSO.jpg",
        "https://c8.alamy.com/comp/M87PH7/birth-place-of-mewars-legendary-king-maharana-pratap-kumbhalgarh-fort-M87PH7.jpg",
        "https://live.staticflickr.com/1624/24716302399_d2fe861b66_b.jpg",
      ],
      "category": "History",
      "isRecommended": false
    },
    {
      "name": "Mount Rushmore",
      "location": "America",
      "show_location": "America",
      "price": 20500,
      "description":
          "Mount Rushmore National Memorial is a massive sculpture carved into Mount Rushmore in the Black Hills region of South Dakota. Completed in 1941 under the direction of Gutzon Borglum and his son Lincoln, the sculpture's roughly 60-ft.-high granite faces depict U.S. presidents George Washington, Thomas Jefferson, Theodore Roosevelt and Abraham Lincoln. The site also features a museum with interactive exhibits. \n Established: 3 March 1925 \n Opened: 31 October 1941 \n\nThe sculptor and tribal representatives settled on Mount Rushmore, which also has the advantage of facing southeast for maximum sun exposure. Doane Robinson wanted it to feature American West heroes, such as Lewis and Clark, their expedition guide Sacagawea, Oglala Lakota chief Red Cloud, Buffalo Bill Cody, and Oglala Lakota chief Crazy Horse. Borglum believed that the sculpture should have broader appeal and chose the four presidents. \n\nPeter Norbeck, U.S. senator from South Dakota, sponsored the project and secured federal funding. Construction began in 1927; the presidents' faces were completed between 1934 and 1939. After Gutzon Borglum died in March 1941, his son Lincoln took over as leader of the construction project. Each president was originally to be depicted from head to waist, but lack of funding forced construction to end on October 31, 1941.",
      "images": [
        "https://media.npr.org/assets/img/2019/11/26/ap_19081671420341_wide-ea5e9a7b5fe7fad7107db1d9ff60f1c4df908935.jpg?s=1400",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3f2rbbeWMBrDXidAcSUJJWSwK0BFspVAXhy0gSNw_6H-4akKLy2e_QET30v9dmNHor-I&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTNXTvaudhri80gBFFdF4vGd9571m49nm325HZW0W9fpsm6LhWcebujzjXPhnop_1ZTHQ&usqp=CAU",
        "https://bloximages.newyork1.vip.townnews.com/kpcnews.com/content/tncms/assets/v3/editorial/a/8a/a8a19f50-0ad7-5af6-b19a-778d50bae322/5f57e06a00e58.image.jpg?resize=667%2C500",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpmYtemWmqKFsyXbPHj_jsG3OZi-1NYiR-GmXtn_mrVe8m9pT_Zd-usKmaZZvaJWM-YrE&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg0-G793PrMmFy1jXu-ddWKNhZ4wbvc5k6fQ&usqp=CAU",
      ],
      "category": "History",
      "isRecommended": false
    },
    {
      "name": "Fremantle Prison",
      "location": "Europe",
      "show_location": "Europe",
      "price": 12300,
      "description":
          "Fremantle Prison, sometimes referred to as Fremantle Gaol or Fremantle Jail, is a former Australian prison and World Heritage Site in Fremantle, Western Australia. The six-hectare site includes the prison cellblocks, gatehouse, perimeter walls, cottages, and tunnels. \n Address: 1 The Terrace, Fremantle WA 6160, Australia \n\n Royal Commissions were held in 1898 and 1911, and instigated some reform to the prison system, but significant changes did not begin until the 1960s. The government department in charge of the prison underwent several reorganisations in the 1970s and 1980s, but the culture of Fremantle Prison was resistant to change. Growing prisoner discontent culminated in a 1988 riot with guards taken hostage, and a fire that caused \$1.8 million worth of damage. The prison closed in 1991, replaced by the new maximum-security Casuarina Prison. \n\nThe prison was administered by a comptroller general, sheriff, or director, responsible for the entire convict or prison system in Western Australia, and a superintendent in charge of the prison itself. Prison officers, known as warders in the 19th century, worked under stringent conditions until they achieved representation through the Western Australian Prison Officers' Union. Convicts were initially of good character as potential future colonists, but less desirable convicts were eventually sent.",
      "images": [
        "https://lp-cms-production.imgix.net/2019-06/cdedbda583f96b6b827af186e4137845-fremantle-prison.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/4/49/FremantlePrison3Division.jpg",
        "https://www.architectureanddesign.com.au/getmedia/8c089745-d13b-45f3-908a-dfa64c9e451d/Aerial-Freo-Prison.aspx?width=600&height=450&ext=.jpg",
        "https://i.ytimg.com/vi/4j8NQbxpTb4/hqdefault.jpg",
        "https://culturalattractionsofaustralia.com/wp-content/uploads/2019/03/FREMANTLE-PRISON-small-856x500.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAFXTo6edmTJL_nnSIxGlo0fzcsIRMuvLKFQ&usqp=CAU",
        "https://www.parenthub.com.au/wp-content/uploads/147097183_freo-prison.jpg",
      ],
      "category": "History",
      "isRecommended": false
    },
    {
      "name": "Royal Exhibition",
      "location": "Oceania",
      "show_location": "Oceania",
      "price": 3000,
      "description":
          "The Royal Exhibition Building is a World Heritage-listed building in Melbourne, Victoria, Australia, built in 1879–1880 as part of the international exhibition movement, which presented over 50 exhibitions between 1851 and 1915 around the globe. \n Located in: Carlton Gardens \n Address: 9 Nicholson St, Carlton VIC 3053, Australia \n Architectural styles: Gothic architecture, Rundbogenstil \n\nThe building is representative of the money and pride Victoria had in the 1870s. Throughout the 20th century smaller sections and wings of the building were subject to demolition and fire; however, the main building, known as the Great Hall, survived. \n\nIt received restoration throughout the 1990s and in 2004 became the first building in Australia to be awarded UNESCO World Heritage status, being one of the last remaining major 19th-century exhibition buildings in the world. It is the world's most complete surviving site from the International Exhibition movement 1851–1914. It sits adjacent to the Melbourne Museum and is the largest item in Museum Victoria's collection. Today, the building hosts various exhibitions and other events and is closely tied with events at the Melbourne Museum.",
      "images": [
        "https://museumsvictoria.com.au/media/13683/000271791-30.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFHKWBEc7BXongLQjOgNczu6R1WwNuWC0XenpBy7XwdEykum3Eub1IVeZ4mVM7Wb1w5NI&usqp=CAU",
        "https://upload.wikimedia.org/wikipedia/commons/4/43/Royal_exhibition_building_tulips_straight.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfWsHJrNxyfKY6EO4OcKloNv3672ZxeLghQ1w0teoobtl9rfB-QEJ1OhEpG0SCmUuaJxw&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS452eVG7vF3xUHVmP1cL2B3IeCkhM5OpoLT7D-0g6vv0W-CceLXgqtKLgAVXzqyqbMJ9o&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgNX7rhX1CiKK7_3j_Pknm1xVdlS9FZHbNdr2CK4_8aB4h2h2DqTFq1SKAtCEV0zPjGlc&usqp=CAU",
      ],
      "category": "History",
      "isRecommended": false
    },
    {
      "name": "Stonehenge",
      "location": "America",
      "show_location": "America",
      "price": 5100,
      "description":
          "Stonehenge is a prehistoric monument on Salisbury Plain in Wiltshire, England, two miles west of Amesbury. It consists of an outer ring of vertical sarsen standing stones, each around 13 feet high, seven feet wide, and weighing around 25 tons, topped by connecting horizontal lintel stones. \n Address: Salisbury SP4 7DE, United Kingdom \n Materials: Sarsen, Bluestone \n Height: Each standing stone was around 13 ft (4.0 m) high \n\nThe whole monument, now ruinous, is aligned towards the sunrise on the summer solstice. The stones are set within earthworks in the middle of the densest complex of Neolithic and Bronze Age monuments in England, including several hundred tumuli (burial mounds). \n\nArchaeologists believe that Stonehenge was constructed from 3000 BC to 2000 BC. The surrounding circular earth bank and ditch, which constitute the earliest phase of the monument, have been dated to about 3100 BC. Radiocarbon dating suggests that the first bluestones were raised between 2400 and 2200 BC, although they may have been at the site as early as 3000 BC. \n\nOne of the most famous landmarks in the United Kingdom, Stonehenge is regarded as a British cultural icon. It has been a legally protected Scheduled Ancient Monument since 1882, when legislation to protect historic monuments was first successfully introduced in Britain.",
      "images": [
        "https://www.worldatlas.com/r/w2560-q80/upload/a6/ca/87/shutterstock-1601037709.jpg",
        "https://ichef.bbci.co.uk/news/976/cpsprodpb/11D0C/production/_106827927_capture.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa74cS_9eC5gVlkSGg9BhLWRFzawZBri8nGg&usqp=CAU",
        "https://cdn.images.express.co.uk/img/dynamic/151/590x/secondary/Ancient-use-Experts-have-debated-what-Stonehenge-s-purpose-was-for-years-3848156.jpg?r=1641714811156",
        "https://i0.wp.com/the-past.com/wp-content/uploads/2022/02/post-1_image0-10.jpg?ssl=1",
        "https://historia-arte.com/_/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpbSI6WyJcL2FydHdvcmtcL2ltYWdlRmlsZVwvNjEwNmQxMjliYjA5My5qcGciLCJyZXNpemUsODAwIl19.fIno0m4uhWzoEVD7si3WLde0xu5rRxZP81ZzkVEQGB8.jpg",
      ],
      "category": "History",
      "isRecommended": false
    },
    {
      "name": "Antarctic Desert",
      "location": "Oceania",
      "show_location": "Oceania",
      "price": 20100,
      "description":
          "Antarctica is a desert. It does not rain or snow a lot there. When it snows, the snow does not melt and builds up over many years to make large, thick sheets of ice, called ice sheets. Antarctica is made up of lots of ice in the form of glaciers, ice shelves and icebergs. Antarctica has no trees or bushes. \n Surface Area: 5,500,000 sq mi (14,244,934 sq km) \n\nThe ice shelves of Antarctica were probably first seen in 1820, during a Russian expedition led by Fabian Gottlieb von Bellingshausen and Mikhail Lazarev. The decades that followed saw further exploration in French, American, and British expeditions. The first confirmed landing was by a Norwegian team in 1895. In the early 20th century, there were a few expeditions into the interior of the continent. British explorers were the first to reach the magnetic South Pole in 1909, and the geographic South Pole was first reached in 1911 by Norwegian explorers. \n\nAntarctica is governed by about 30 countries, all of which are parties of the 1959 Antarctic Treaty System. According to the terms of the treaty, military activity, mining, nuclear explosions, and nuclear waste disposal are all prohibited in Antarctica. Tourism, fishing and research are the main human activities in and around Antarctica.",
      "images": [
        "https://www.auroraexpeditions.com.au/wp-content/uploads/2020/02/is-antarctica-a-dessert.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkt5LTe9BZz_GH5w3AD0EMgWGCQl_ZUbbERuc9B9T6iML20Tdy-JGL0P5uWJKdEK6iO9Y&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGUUzjIe7YV0iq_RpwH173wUQJNSg-g7YQvWdksrdr9XaorQqfR4rljBvsm-I9SFkfSas&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBSqEQKP8gBMrSu_Vt9Z3bBYeixG_YeiPaewd8XOfQ8W25P47TfXQ8oTTQ9VLLKFsGTlY&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwjoKgfFe5AQyOv1udIEkSGBfL0hWb4ofcylvJiEkDuxsVy5wb4ivQo3H6Ekr61bhSlUE&usqp=CAU",
        "https://www.universetoday.com/wp-content/uploads/2016/03/McMurdo-Station-Night-e1459363908503.jpg",
        "https://www.researchgate.net/profile/Thulani-Makhalanyane/publication/321944158/figure/fig1/AS:712444007698433@1546871296303/Antarctic-desert-soils-Ji-et-al-3-report-an-analysis-of-microbial-communities-in.png",
      ],
      "category": "Desert",
      "isRecommended": false
    },
    {
      "name": "Sahara Desert",
      "location": "America",
      "show_location": "America",
      "price": 23500,
      "description":
          "The Sahara is a desert on the African continent. With an area of 9,200,000 square kilometres, it is the largest hot desert in the world and the third-largest desert overall, smaller only than the deserts of Antarctica and the northern Arctic. \n Area: 9.2 million km² \n Length: 4,800 km (3,000 mi) \n\nThe desert comprises much of North Africa, excluding the fertile region on the Mediterranean Sea coast, the Atlas Mountains of the Maghreb, and the Nile Valley in Egypt and the Sudan. It stretches from the Red Sea in the east and the Mediterranean in the north to the Atlantic Ocean in the west, where the landscape gradually changes from desert to coastal plains. To the south it is bounded by the Sahel, a belt of semi-arid tropical savanna around the Niger River valley and the Sudan region of sub-Saharan Africa. The Sahara can be divided into several regions, including the western Sahara, the central Ahaggar Mountains, the Tibesti Mountains, the Aïr Mountains, the Ténéré desert, and the Libyan Desert. \n\nFor several hundred thousand years, the Sahara has alternated between desert and savanna grassland in a 20,000-year cycle caused by the precession of Earth's axis as it rotates around the Sun, which changes the location of the North African monsoon.",
      "images": [
        "https://www.onthegotours.com/blog/wp-content/uploads/2019/08/Oasis-over-Sand-dunes-in-Erg-Chebbi-of-Sahara-desert-in-Morocco-Africa.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgDwmHdzJL3KLFa9GQHwz-geXfjYeJnrsRXlwgS9lXfYomLdKOyhRMKIkucnwy58OVG3Q&usqp=CAU",
        "https://cdn.britannica.com/10/152310-050-5A09D74A/Sand-dunes-Sahara-Morocco-Merzouga.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8Fo90IpwrTk1xs2K3kVrIulPfebafv-P7bcHk0vHNlexhILShW5t7cUh4VCIF9mJXcLA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKVuOiBbl0ryZgfNsAVmbIqMuTwWcEb1C6eYFytYbex9p1KEEo99NDmLsgSAmiWK5KlfI&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqrWyLI_ipYJiexaG5cdyO85d1RXSoXT7UiK9XDD3EDg9_6oN987GOGwrfmtogNnWJDTw&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRH5XHmC4CBweZBv_msrqGLiD2BQY7CeE3NVcbsk2xjjx90kmRcIU2z9YW3LdVrP-Tupo&usqp=CAU"
      ],
      "category": "Desert",
      "isRecommended": false
    },
    {
      "name": "Arabian Desert",
      "location": "Asia",
      "show_location": "Western Asia",
      "price": 7800,
      "description":
          "Arabian Desert Tours & Safari, a Tourism organisation/Service provider is one of the leading full-service destination management company in the United Arab Emirates. We have our home base centrally located in Abu Dhabi. So that we can swiftly and easily attend our guests with everything they need for the perfect cruise, desert safari, or tour. We offer a comprehensive range of tourism products and services. We offer exciting and adventurous desert safari, other tours and excursions within the UAE. Visit us, as we look forward to greeting you and having the privilege of showing you more of this wonderful city and its surroundings. \n\nThe climate is mostly dry (the major part receives around 100 mm (3.9 in) of rain per year but some very rare places receive as little as 50 mm), and temperatures oscillate between very high heat and seasonal night time freezes. It is part of the deserts and xeric shrublands biome and lie in biogeographical realms of the Palearctic (northern part) and Afrotropical (southern part).",
      "images": [
        "https://www.worldatlas.com/r/w1200/upload/66/7d/51/shutterstock-1619559943.jpg",
        "https://mybayutcdn.bayut.com/mybayut/wp-content/uploads/Arabian-Desert-Cover-20210517.jpg",
        "https://www.google.com/search?q=Arabian+Desert&tbm=isch&ved=2ahUKEwiLl9-7qvb5AhW2i9gFHRnWBPEQ2-cCegQIABAA&oq=Arabian+Desert&gs_lcp=CgNpbWcQAzIICAAQgAQQsQMyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQ6BAgAEENQgwtYgwtg3BJoAHAAeACAAZMBiAGVApIBAzAuMpgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=5xQSY8uHGLaX4t4PmayTiA8&bih=673&biw=740&rlz=1C1CHBF_enIN926IN926#imgrc=lUQBGD7vMX6azM&imgdii=qtjR8di3vSAfvM",
        "https://cdn.britannica.com/39/95539-050-CE0F264B/landscape-Riyadh-Saudi-Arabia.jpg?w=300&h=169&c=crop",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTammdeLRECiA0LtNXQm3rnQ1wch-3imqQMJBvXHnx9idtUaWMg2qQk1_XV8YCCZ-dSw_Q&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtx-p-Iy5kWX17ouorMjVreVa86y4oCEroUpyZA3j9hgt5jnFIKNw242rKJ3B5zpE2fIg&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAU0881lWnj0kBvvjlptv86lJKTFZn8koOOdYbPzTGDVckrDMyYpWtXDGHLWMPlV83o20&usqp=CAU",
      ],
      "category": "Desert",
      "isRecommended": false
    },
    {
      "name": "Death Valley",
      "location": "America",
      "show_location": "America",
      "price": 7100,
      "description":
          "Death Valley is a desert valley in Eastern California, in the northern Mojave Desert, bordering the Great Basin Desert. During summer, it is one of the hottest places on Earth, along with deserts in the Middle East and the Sahara. \n Elevation: -86 m \n Lowest elevation: 86 m (Below sea level) \n Area: 3,000 square miles (7,800 km2) \n Rivers: Furnace Creek; Amargosa River \n\nDeath Valley's Badwater Basin is the point of lowest elevation in North America, at 282 feet (86 m) below sea level. It is 84.6 miles (136.2 km) east-southeast of Mount Whitney, the highest point in the contiguous United States, with an elevation of 14,505 feet (4,421 m). On the afternoon of July 10, 1913, the United States Weather Bureau recorded a high temperature of 134 °F (56.7 °C) at Furnace Creek in Death Valley,[5] which stands as the highest ambient air temperature ever recorded on the surface of the Earth. This reading, however, and several others taken in that period, a century ago, are disputed by some modern-day experts.",
      "images": [
        "https://npf-prod.imgix.net/uploads/2016020920-20shutterstock_84004441.jpg?auto=compress%2Cformat&crop=focalpoint&fit=min&fp-x=0.5&fp-y=0.5&h=900&q=80&w=1600",
        "https://i.ytimg.com/vi/nZrI14lXFHk/hqdefault.jpg",
        "https://pvtimes.com/wp-content/uploads/2022/08/16791024_web1_JUMP2.jpg?crop=1",
        "https://www.visitcalifornia.com/sites/visitcalifornia.com/files/styles/welcome_image/public/VC_DeathValleyFloraFauna_Hero_DeathValley_Stock_RF_474136334_1280x640.jpg",
        "https://img.freepik.com/free-photo/sunny-scenery-artist-drive-death-valley-national-park-california-usa_181624-34993.jpg?w=2000",
        "https://i.natgeofe.com/n/94b2bb39-7525-4c49-b7fb-8f9e02525f32/2078.jpg?w=636&h=477",
        "https://www.travelandleisure.com/thmb/68LUvgpXRDcqb-vJNowcv_wlhUY=/400x0/filters:no_upscale():max_bytes(150000):strip_icc():gifv()/north-kelbaker-seventeen-mile-point-DVRDCLOSE0822-eb0464a312f6491c982ca80546ca1d2e.jpg",
      ],
      "category": "Desert",
      "isRecommended": false
    },
    {
      "name": "Great Basin desert",
      "location": "Australia",
      "show_location": "Australia",
      "price": 2900,
      "description":
          "The Great Basin Desert is part of the Great Basin between the Sierra Nevada and the Wasatch Range. \n Biome: Deserts and xeric shrublands \n Habitat loss: 90% \n Bird species: 204 \n Mammal species: 105 \n\nIt is a temperate desert with hot, dry summers and snowy winters. The desert spans large portions of Nevada and Utah, and extends into eastern California. The desert is one of the four biologically defined deserts in North America, in addition to the Mojave, Sonoran, and Chihuahuan Deserts. \n\nBasin and range topography characterizes the desert: wide valleys bordered by parallel mountain ranges generally oriented north–south. There are more than 33 peaks within the desert with summits higher than 9,800 feet (3,000 m), but valleys in the region are also high, most with elevations above 3,900 feet (1,200 m). The biological communities of the Great Basin Desert vary according to altitude: from low salty dry lakes, up through rolling sagebrush valleys, to pinyon-juniper forests. The significant variation between valleys and peaks has created a variety of habitat niches which has in turn led to many small, isolated populations of genetically unique plant and animal species throughout the region. According to Grayson, more than 600 species of vertebrates live in the floristic Great Basin, which has a similar areal footprint to the ecoregion.",
      "images": [
        "https://cdn.britannica.com/34/7934-050-B573BA76/Death-Valley-National-Park-Great-Basin-California.jpg",
        "https://www.desertusa.com/grb/grbphotos/Gnarly_Bristlecone_Pine.jpg",
        "https://image.shutterstock.com/image-photo/dusting-snow-great-basin-high-260nw-1028700100.jpg",
        "https://www.worldatlas.com/r/w768/upload/be/fd/f8/great-basin-desert-winter-utah-us-n-mrtgh.jpg",
        "https://www.worldatlas.com/r/w768/upload/4e/bd/0f/lake-lahontan-great-basin-desert-nevada-us-dominic-gentilcore-phd.jpg",
        "https://pbs.twimg.com/media/DllDPLjW4AAFU7r.jpg",
      ],
      "category": "Desert",
      "isRecommended": false
    },
    {
      "name": "Sonoran Desert",
      "location": "America",
      "show_location": "North America",
      "price": 3600,
      "description":
          "The Sonoran Desert is a North American desert and ecoregion that covers large parts of the southwestern United States, as well as the northwestern Mexican states of Sonora, Baja California, and Baja California Sur. It is the hottest desert in both Mexico and the United States. \n Area: 222,998 km² \n Biome: Deserts and xeric shrublands \n Bird species: 246 \n Rivers: Colorado River \n\nThe Sonoran Desert is clearly distinct from nearby deserts (e.g., the Great Basin, Mojave, and Chihuahuan deserts) because it provides subtropical warmth in winter and two seasons of rainfall (in contrast, for example, to the Mojave's dry summers and cold winters). This creates an extreme contrast between aridity and moisture. \n\nThe Sonoran desert wraps around the northern end of the Gulf of California, from Baja California Sur (El Vizcaíno Biosphere Reserve in central and Pacific west coast, Central Gulf Coast subregion on east to southern tip), north through much of Baja California, excluding the central northwest mountains and Pacific west coast, through southeastern California and southwestern and southern Arizona to western and central parts of Sonora.",
      "images": [
        "https://cff2.earth.com/uploads/2018/02/09182927/Cacti-birds-and-life-in-the-Sonoran-Desert.jpg",
        "https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/ff/84/cf.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCnC8CsoJW6U4m0eXN5XXBIs-TFVCn5iClYg&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL7M-96u4Frt10NaNi6qT9w_Z4Lpf5MO05Ug&usqp=CAU",
        "https://static3.bigstockphoto.com/4/9/6/large1500/69471955.jpg",
      ],
      "category": "Desert",
      "isRecommended": false
    },
    {
      "name": "Thar Desert",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 3300,
      "description":
          "The Thar Desert, also known as the Great Indian Desert, is an arid region in the north-western part of the Indian subcontinent that covers an area of 200,000 km² and forms a natural boundary between India and Pakistan. It is the world's 20th-largest desert, and the world's 9th-largest hot subtropical desert. \n Area: 238,254 km² \n Borders: Northwestern thorn scrub forests and Rann of Kutch seasonal salt marsh \n Biome: Deserts and xeric shrublands \n\nAbout 85% of the Thar Desert is in India, and about 15% is in Pakistan.[3] The Thar Desert is about 4.56% of the total geographical area of India. More than 60% of the desert lies in the Indian state of Rajasthan; the portion in India also extends into Gujarat, Punjab, and Haryana. The portion in Pakistan extends into the provinces of Sindh[4] and Punjab (the portion in the latter province is referred to as the Cholistan Desert). \n\nSaltwater lakes within the Thar Desert include the Sambhar, Kuchaman, Didwana, Pachpadra, and Phalodi in Rajasthan and Kharaghoda in Gujarat. These lakes receive and collect rainwater during monsoon and evaporate during the dry season. The salt comes from the weathering of rocks in the region.",
      "images": [
        "https://www.rajasthantourplanner.com/blog/wp-content/uploads/2020/06/Desert-camping-1.jpg",
        "https://static.toiimg.com/photo/68427211.cms",
        "https://cdn.britannica.com/44/162744-050-ADEB53F2/Thar-Desert-India-Rajasthan.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFvuy7KglrycZUy4Ku9udu6VBoZ0rXfhFRlw&usqp=CAU",
        "https://pix10.agoda.net/hotelImages/111/11124644/11124644_19121821360086039016.jpg?ca=9&ce=1&s=1024x768",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIOfiV5jfRVn7Rhz2QvQuAvgpA-KySzc3kig&usqp=CAU",
      ],
      "category": "Desert",
      "isRecommended": false
    },
    {
      "name": "ladakh cold desert",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 4000,
      "description":
          "Ladakh is a cold desert lying in the Great Himalayas, on the eastern side of Jammu and Kashmir. The Karakoram Range in the north and the Zanskar mountains in the south enclose it. Several rivers flow through Ladakh, Indus being the most important among them. The rivers form deep valleys and gorges.\n\n The altitude in Ladakh varies from about 3000m in Kargil to more than 8,000m in the Karakoram. Due to its high altitude, the climate is extremely cold and dry. The air at this altitude is so thin that the heat of the sun can be felt intensely. The day temperatures in summer are above zero degree. The night temperatures remains well below 30C. It is freezing cold in the winters. As it lies in the rain shadow of the Himalayas, there is little rainfall, as low as 10 cm every year. The area experiences freezing winds and burning hot sunlight. \n\nDue to high aridity, the vegetation is sparse in the cold desert of Ladakh. There are scanty patches of grasses and shrubs for animals to graze. Groves of willows and poplars are seen in the valleys. During the summers, fruit trees such as apples, apricots and walnuts bloom.",
      "images": [
        "https://d1whtlypfis84e.cloudfront.net/guides/wp-content/uploads/2018/02/22080114/The-Cold-desert-Ladakh-300x188.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROpfE33zCb9czl8HdSy91yCA6wM7LtTOdhDgqfDZfRpsqvg3QrCCiUNMGelmvlp2YRysk&usqp=CAU",
        "https://i.ytimg.com/vi/FxfhX46XIhg/hqdefault.jpg",
        "https://jeweltravel.files.wordpress.com/2017/07/wp-image-466163968.jpg",
        "https://www.lehladakhindia.com/blog/wp-content/uploads/2016/01/LLI-nubra-valley.jpg",
        "https://travellinkslive.com/wp-content/uploads/2020/04/WhatsApp-Image-2020-04-03-at-12.06.33-PM-1-960x640.jpeg",
        "https://cdn.indiastockphoto.com/wp-content/uploads/2021/05/Nubra-valley-Ladakh-with-camel.jpg",
      ],
      "category": "Desert",
      "isRecommended": false
    },
    {
      "name": "Rann of Kutch",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 6000,
      "description":
          "The Great Rann of Kutch is a salt marsh in the Thar Desert in the Kutch District of Gujarat, India. It is about 7500 km² in area and is reputed to be one of the largest salt deserts in the world. This area has been inhabited by the Kutchi people. \n\nRann of Kutch is a massive expanse of cracked earth, inland from the sea, that promises to take your breath away. The nothingness for miles is both nerve wracking and stunning with small oasis of water bodies and shrub forests doubling up as homes for pink flamingoes and wild asses. Tribal hamlets with cylindrical mud bhungas (huts) are the epicenter for Kutchi embroidery, tie and dye, leatherwork, pottery, bell metal craft and the famous Rogan painting by the only surviving expert family. Approximately 200 km east of the Rann, is the Little Rann of Kutch, which houses the 4953-sq-km Wild Ass Sanctuary. It homes the only remaining population of the chestnut-coloured Indian wild ass (khur), as well as blue-bulls, blackbuck and chinkara. \n\nThe area was a once a sprawling shallow of the Arabian Sea until a constant geological shift closed off the connection with the sea. Over the years, the region eventually became a seasonal marshy salt desert. During monsoons, the marsh fills up with water and the wetland extends from the Gulf of Kutch on the west through to the Gulf of Cambay on the east. ",
      "images": [
        "https://www.tripsavvy.com/thmb/FbaLdyaHvRSsZ2QqcnUckE-nhJE=/1883x1412/smart/filters:no_upscale()/GettyImages-537000923-541774dbe2d44759815fdf0719b04685.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMsPMECkIAqUxTq8E12cft9WwOF--AMZEo4T4xeFW4taZH9rh5bpha1RIJT-HbEns0-fs&usqp=CAU",
        "https://blogger.googleusercontent.com/img/a/AVvXsEh1re5XJVTtcfSYrfbTtR6-KNHCg9LHT2ykALPDSI--0IIIaX4SAN6aB_y_mGQ5ZIgG23Ke5IDJtrje_6aaBKVLklSEW9l9RZvZ6mQLBa4O_P3jh0dk43cIuEZtO5-WQLujiInvMD0DCpoQHstTpxy4fvk7Hofi4L1Y423RCqMLj0_Ita9hf4nIkzZbUg=w640-h480",
        "https://media.news9live.com/h-upload/2022/02/17/241836-rann.jpg",
        "https://www.hyundai.com/content/dam/hyundai/in/en/data/hyundai-story/Hyundai%20ALCAZAR_Premium%20SUV_6&7%20seater%20SUV_Welcome_%20NAme%20Formation_560x358_1.png",
        "https://www.deccanherald.com/sites/dh/files/styles/article_detail/public/articleimages/2022/01/09/file7j38d2jkz53f4nzxjhe-1068479-1641670201.jpg?itok=xW9oVQiG",
        "https://backpackclan.com/wp-content/uploads/2020/04/rann.jpg",
      ],
      "category": "Desert",
      "isRecommended": false
    },
  ];

  List rec = [
    {
      "name": "Pink Beach",
      "location": "Asia",
      "show_location": "West Asia",
      "price": 2500,
      "description":
      "Lombok is an island in Indonesia, famous for its giant active volcano Mount Rinjani (or ‘Gunung Rinjani’). Lombok is part of the Lesser Sunda Islands, of which its nearest neighbour is the famous Island of Bali. \n\nOn Lombok Island you’ll find the culture is heavily influenced by the neighbouring island of Bali. Like the Balinese, the Lombok people are predominantly Muslim – inheriting their religion from the original settlers of Lombok, who were known as the Sasak. \n\nPink Beach (Pantai Tangsi) sits at the edge of a tiny fishing village called Sekaroh in the district of Jerowaru on the Ekas Peninsula, an extremely remote area of Lombok’s east coast.",
      "images": [
        "https://external-preview.redd.it/P27URL9OW8NfZvNuJWikyRCPWOupBPs1dSHfYsKsPLY.jpg?auto=webp&s=b04811eb285c2c1292ea1c64803b6dff0d105e6a",
        "https://www.planetware.com/wpimages/2020/09/world-best-pink-sand-beaches-elafonissi-beach-greece.jpg",
        "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/elafonisi-lagoon-crete-island-greece-royalty-free-image-577324858-1551472750.jpg?crop=0.84371xw:1xh;center,top&resize=480:*",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2FaYEmG95LcmLem0V_WCz3POSrQ1P_8gXPNmNxWv7EwdVNkbXJjpAl9jO8JIMkD2ZZP8&usqp=CAU",
        "https://images.unsplash.com/photo-1562008928-6185cc645f76?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGluayUyMGJlYWNofGVufDB8fDB8fA%3D%3D&w=1000&q=80",
        "https://www.travelandleisure.com/thmb/B9aLIeZ_p3C0WyKKQ8ma_izGimE=/1600x1000/filters:fill(auto,1)/Pink-Sand-Beach-Harbour-Island-The-Bahamase-PINKBEACHES1117-4e4ae197d53a4f55a863429b5390b667.jpg",
        "https://i.pinimg.com/originals/bc/52/48/bc5248497996721ce81d9430ccfb1cbb.png",
        "https://i.pinimg.com/736x/85/4d/19/854d199909a0375c60dcfa6aa225f4c6--pink-sunset-pink-beach.jpg",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Koh Yao Yai",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 2700,
      "description":
      "Ko Yao Yai is a Thai island in the Andaman Sea, halfway between Phuket and Krabi. It's characterized by sandy shores, mangroves, rubber plantations and fishing villages. Beaches include Loh Paret and Loh Jark, the latter with a pier for ferries and long-tail boats. The surrounding waters are rich in coral and dotted with dive sites, like the King Cruiser Wreck near Anemone Reef, and the pinnacles of Shark Point. \n Max length: 30 km \n\nKo Yao Yai is the larger of the two big islands in the Ko Yao Archipelago. The island group is in Phang Nga Bay in the Phang Nga Province of southern Thailand. Ko Yao Yai means 'big long island'. The other main island of the group is Ko Yao Noi ('little long island'), off Ko Yao Yai's north side and separated from it by a narrow sound. The two islands form Phang Nga's Ko Yao District. The population of Ko Yao is about 18,000 (2018). Ninety percent are Muslims. The area of the archipelago is 147 km2. It lies some 600 km south of Bangkok and about 50 km from Phuket or Phang Nga. Ko Kao Noi is more popular with visitors as it has more facilities.",
      "images": [
        "https://pix10.agoda.net/hotelImages/335179/-1/1357801386bc408525f15c80dff1c435.png?ce=0&s=1024x768",
        "https://www.jahnreisen.de/pibe-media/mwr/hotel/HKT30023-FZ_S22_13.jpg",
        "https://www.oyster.com/wp-content/uploads/sites/35/2019/05/pool-v6759879-1440-1024x683.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-s/09/00/90/d3/santhiya-koh-yao-yai.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-s/12/e9/7f/96/santhiya-koh-yao-yai.jpg",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Cox's Bazar",
      "location": "Asia",
      "show_location": "South Asia",
      "price": 1500,
      "description":
      "Cox’s Bazar is a town on the southeast coast of Bangladesh. It’s known for its very long, sandy beachfront, stretching from Sea Beach in the north to Kolatoli Beach in the south. Aggameda Khyang monastery is home to bronze statues and centuries-old Buddhist manuscripts. South of town, the tropical rainforest of Himchari National Park has waterfalls and many birds. North, sea turtles breed on nearby Sonadia Island. \n Area: 23.4 km² \n Weather: 29 °C, Wind W at 8 km/h, 81% Humidity \n\nCox's Bazar Beach (Bengali: কক্সবাজার সমুদ্র সৈকত), located at Cox's Bazar, Bangladesh, is the longest natural sea beach in the world running 120 kilometres (75 mi)[1][2][3][4][5] and 5th longest beach after Praia do Cassino of Brazil, Padre Island on the US Gulf Coast, Eighty Mile Beach in Western Australia, and Ninety Mile Beach of Australia. It is the top tourist destination of Bangladesh. \n\nAt high tide the beach is 200 metres (660 ft) wide and at low tide it is 400 metres (1,300 ft) wide on average. Quicksand is a danger during ebb tide. \n\nKolatoli Point (Bengali: কলাতলী পয়েন্ট) is an important part of Cox's Bazar beach[10] situated near Dolphine intersection of Cox's Bazar city.",
      "images": [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/10/e2/f8/43/longest-sea-beach-in.jpg?w=700&h=-1&s=1",
        "https://1.bp.blogspot.com/-zw3lQgq-v4s/YVsbovs5AwI/AAAAAAAABh8/UuzaqklCG7ICl-OZFHRWpD5ajLs7ZrVXgCLcBGAsYHQ/s1280/Best%2BThings%2BTo%2BDo%2Bin%2BCox%25E2%2580%2599s%2BBazar%2B.png",
        "https://media-cdn.tripadvisor.com/media/photo-s/15/99/54/30/swimming-pool.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/c/cf/Cox%27s_Bazaar_Sunset_Sep2019.jpg",
        "https://cdn.pixabay.com/photo/2018/03/20/14/00/sea-3243357__480.jpg",
        "https://wikitravel.org/upload/shared//thumb/f/fe/Sunsetatcoxsbazar.jpg/400px-Sunsetatcoxsbazar.jpg",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Maui",
      "location": "America",
      "show_location": "South America",
      "price": 9900,
      "description":
      "Maui is an island in the Central Pacific, part of the Hawaiian archipelago. Sprawling Haleakala National Park encompasses the island’s highest peak, volcanic Haleakala, as well as the pools and waterfalls of Ohe’o Gulch, accessed via scenic, winding Hana Highway. The island's 30 miles of beaches include golden-crescent Kapalua, sheltered from strong currents by lava-rock promontories. \n Area: 1,884 km² \n Max length: 64 km \n Max width: 42 km \n Highest elevation: 10,023 ft (3055 m) \n\nMaui, known also as “The Valley Isle,” is the second largest Hawaiian island. The island beloved for its world-famous beaches, the sacred Iao Valley, views of migrating humpback whales (during winter months), farm-to-table cuisine and the magnificent sunrise and sunset from Haleakala. It’s not surprising Maui has been voted 'Best Island in the U.S.' by Condé Nast Traveler readers for more than 20 years. Check out the regions of Maui and all this island has to offer. \n\nWith 120 miles of coastline, Maui boasts over 30 miles of beautiful beaches. On these world famous shores you’ll find white or black sand beaches, renowned surfing and windsurfing spots as well as some of the best beaches in the world to simply swim, snorkel and sunbathe. Many are easily accessible beach parks with lifeguards, picnic facilities and restrooms.",
      "images": [
        "https://www.gohawaii.com/sites/default/files/styles/wide_carousel_large/public/content-carousel-images/10105_mauiregionslp_VideoThumbnail.jpg?itok=vzKj-jK9",
        "https://assets3.thrillist.com/v1/image/2423365/1200x630/flatten;crop_down;webp=auto;jpeg_quality=70",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD0J1JiMs6lXICJOjQu_wmfJxKRXL7Eqi2LrHq6HIAIKVSv-RvL0fzFs1vjcqFLHRcgoc&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWVa-nPuDcZeB_oQXE2-YoRyf672J-1UWoFescMbi_otDmd5MYnmcTIP6m20hY35qA7wA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWHfPkwAI2_zDcJol0L3HDAawDFBHEMVxEfkeuXy2Y3DERPA3G9-ciWlWAR42ZkeEjt_8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgPoIuJPuDTLngaU6voi_POUK0uLluvZwHH9OgxnU6gay3lyq8cn2tSidYE_NDGGQLcFg&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsu9ADS7hIEBIR6rxXS4l0dVXflA4M5RQkGylFjWshkL8L9KcBJiwLUmEHiyDx-sY715U&usqp=CAU",
      ],
      "category": "Beach",
      "isRecommended": false
    },
    {
      "name": "Miami Beach",
      "location": "Oceania",
      "show_location": "Oceania",
      "price": 4500,
      "description":
      "Miami Beach is a south Florida island city, connected by bridges to mainland Miami. Wide beaches stretch from North Shore Open Space Park, past palm-lined Lummus Park to South Pointe Park. The southern end, South Beach, is known for its international cachet with models and celebrities, and its early-20th-century architecture in the Art Deco Historic district with pastel-colored buildings, especially on Ocean Drive. \n Area: 39.42 km² \n Founded: 26 March 1915 \n Elevation: 1.22 m \n Local time: Friday, 5:44 am \n Weather: 27 °C, Wind E at 2 km/h, 79% Humidity \n\nMiami Beach is a coastal resort city in Miami-Dade County, Florida. It was incorporated on March 26, 1915. The municipality is located on natural and man-made barrier islands between the Atlantic Ocean and Biscayne Bay, the latter of which separates the Beach from the mainland city of Miami. The neighborhood of South Beach, comprising the southernmost 2.5 square miles (6.5 km2) of Miami Beach, along with Downtown Miami and the PortMiami, collectively form the commercial center of South Florida. Miami Beach's population is 82,890 according to the 2020 census. Miami Beach is the 26th largest city in Florida based on official 2019 estimates from the U.S. Census Bureau. It has been one of America's pre-eminent beach resorts since the early 20th century. \n\nIn 1979, Miami Beach's Art Deco Historic District was listed on the National Register of Historic Places.",
      "images": [
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Miamibeach.jpg/800px-Miamibeach.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4PaWwSuTe8DoxX2aHJ4B9w0tef0MK8Y1_o1fxskkCj-rkCG-hBtdKL0xXNHmpMX8p6aA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8LNyqfCdymz7ypzp3L6v9o3-R5y7HotDSw4wGtuBXmSRTdAw0BzMmTdlhplHZwmzJBtk&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM5LUIKFGa89gtpx5pLlm43wcpthw1Oi5KXNFnUYwkai5xNDmfUgDUt5l_1yww64n9jk8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNHVbrgndLJe7UP7NtPeqjirxlgomHMx0C0-9jiFjwbqdmIi-5KF3jFrm5pLHHZXG3enE&usqp=CAU",
        "https://www.worldatlas.com/r/w768/upload/51/df/3a/shutterstock-1341544250.jpg",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/cd/02/3d/caption.jpg?w=500&h=300&s=1&cx=430&cy=826&chk=v1_495186e7d60a7db91378",
      ],
      "category": "Beach",
      "isRecommended": false
    },
  ];

  void addRecList()async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    CollectionReference ref = FirebaseFirestore.instance.collection("recommended");
    for (var e in rec) {
      batch.set(ref.doc(), e);
    }
    await batch.commit();

  }

  void addData() async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    CollectionReference ref = FirebaseFirestore.instance.collection("places");
    for (var e in data) {
      batch.set(ref.doc(), e);
    }
    await batch.commit();
  }

  void updateData() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      LoadingDialog.showLoadingDialog();
      final Map<String, dynamic> userData = {
        "name": _nameController.text,
        "userName": _userNameController.text,
        "dob": dob.text,
        "gender": gender,
        "email": _mailController.text,
        "mobile": _mobileController.text,
        "id": UserProfile.id
      };
      if (path != null && path!.isNotEmpty) {
        if (!Uri.parse(path!).isAbsolute) {
          String name = path!.split("/").last.split(".").last;
          TaskSnapshot ref = await FirebaseStorage.instance
              .ref("${UserProfile.id}.$name")
              .putFile(File(path!));
          userData['profile'] = await ref.ref.getDownloadURL();
        }
      }
      await FirebaseFirestore.instance
          .collection("users")
          .doc(UserProfile.id)
          .update(userData);
      SharedPreferences _pref = await SharedPreferences.getInstance();
      UserProfile.name = _nameController.text;
      UserProfile.userName = _userNameController.text;
      _pref.setString("name", _nameController.text);
      _pref.setString("userName", _userNameController.text);
      LoadingDialog.hideLoading();
      LoadingDialog.showSuccessToast("Your Profile Update Successfully");
      setState(() {
        isEdit = false;
      });
    } catch (e) {
      print("Error == $e");
      LoadingDialog.hideLoading();
      LoadingDialog.showErrorToast("Something went wrong please try again");
    }
  }

  void uploadCamera({bool isCamera = true}) async {
    final image = await ImagePicker.platform
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      setState(() {
        path = image.path;
      });
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _form,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 25, top: 10),
                  child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isEdit = !isEdit;
                    });
                  },
                  child: Icon(!isEdit ? Icons.edit : Icons.clear),
                ),
              ],
            ),
            isLoading
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: isEdit
                                  ? () {
                                      Get.bottomSheet(Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              onTap: () {
                                                uploadCamera(isCamera: true);
                                              },
                                              title: Text("Camera"),
                                              leading: Icon(Icons.photo_camera),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                uploadCamera(isCamera: false);
                                              },
                                              title: Text("Gallery"),
                                              leading: Icon(Icons.photo),
                                            )
                                          ],
                                        ),
                                      ));
                                    }
                                  : null,
                              child: Container(
                                  height: 120,
                                  width: 120,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(120)),
                                  child: path != null && path!.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(120),
                                          child: Uri.parse(path!).isAbsolute
                                              ? Container(
                                                  height: 120,
                                                  width: 120,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              120)),
                                                  child: Image.network(path!,
                                                      fit: BoxFit.contain),
                                                )
                                              : Image.file(File(path!)),
                                        )
                                      : Text(
                                          _nameController.text.isEmpty
                                              ? ""
                                              : _nameController.text[0]
                                                  .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 78,
                                              color: Colors.white),
                                        )),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 10),
                          child: TextFormField(
                            readOnly: !isEdit,
                            controller: _nameController,
                            validator: (value) =>
                                Validators().validateName(value, "Name"),
                            decoration: const InputDecoration(
                                fillColor: Color.fromRGBO(
                                    189, 187, 187, 0.5647058823529412),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                hintText: "Your name"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 10),
                          child: TextFormField(
                            readOnly: !isEdit,
                            controller: _userNameController,
                            validator: (value) =>
                                Validators().validateName(value, "User Name"),
                            decoration: const InputDecoration(
                                fillColor: Color.fromRGBO(
                                    189, 187, 187, 0.5647058823529412),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                hintText: "Your Username"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 10),
                          child: TextFormField(
                            readOnly: !isEdit,
                            controller: dob,
                            validator: (value) =>
                                Validators().validatedate(value),
                            decoration: const InputDecoration(
                                fillColor: Color.fromRGBO(
                                    189, 187, 187, 0.5647058823529412),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                hintText: "Your DOB"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 10),
                          child: SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  Text("Gender"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Radio(
                                      value: "Male",
                                      groupValue: gender,
                                      onChanged: !isEdit
                                          ? null
                                          : (String? val) {
                                              setState(() {
                                                gender = val!;
                                              });
                                            }),
                                  Text("Male"),
                                  Radio(
                                      value: "Female",
                                      groupValue: gender,
                                      onChanged: !isEdit
                                          ? null
                                          : (String? val) {
                                              setState(() {
                                                gender = val!;
                                              });
                                            }),
                                  Text("Female"),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 10),
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            controller: _mailController,
                            validator: (value) =>
                                Validators.validateEmail(value),
                            decoration: const InputDecoration(
                                fillColor: Color.fromRGBO(
                                    189, 187, 187, 0.5647058823529412),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                hintText: "Your email"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 10),
                          child: TextFormField(
                            readOnly: !isEdit,
                            controller: _mobileController,
                            validator: (value) =>
                                Validators().validateMobile(value),
                            decoration: const InputDecoration(
                                fillColor: Color.fromRGBO(
                                    189, 187, 187, 0.5647058823529412),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                hintText: "Your Mobile"),
                          ),
                        ),
                        /*Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _pwdController,
                      validator: (value) =>
                          Validators().validatePassword(value),
                      obscureText: state,
                      decoration: InputDecoration(
                          fillColor: const Color.fromRGBO(
                              189, 187, 187, 0.5647058823529412),
                          filled: true,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          hintText: "Password",
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  state = !state;
                                });
                              },
                              child: const Icon(Icons.remove_red_eye_rounded))),
                    ),
                  ),*/
                        isEdit
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // addData();
                                    // addRecList();
                                    if (_form.currentState?.validate() ??
                                        false) {
                                      updateData();
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blueAccent),
                                    child: const Text(
                                      "Update",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
