import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/main.dart';
import 'package:home_page/package_screen.dart';
import 'package:home_page/widget/favourite.dart';

import 'config/user.dart';

class Categ extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList;
  final int index;

  const Categ({Key? key, required this.index, required this.dataList})
      : super(key: key);

  @override
  State<Categ> createState() => _CategState();
}

class _CategState extends State<Categ> {
  List beach = [
    {
      'image':
          "https://i.pinimg.com/originals/df/bf/3b/dfbf3bc714551bd3cc54d466398d4863.jpg",
      'name': "Pink Beach",
      'detail':
          "Pale pink sandy beach with clear waters & reef teeming with tropical fish & some strong currents.",
      'gallery': {
        "https://external-preview.redd.it/P27URL9OW8NfZvNuJWikyRCPWOupBPs1dSHfYsKsPLY.jpg?auto=webp&s=b04811eb285c2c1292ea1c64803b6dff0d105e6a",
        "https://www.planetware.com/wpimages/2020/09/world-best-pink-sand-beaches-elafonissi-beach-greece.jpg",
        "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/elafonisi-lagoon-crete-island-greece-royalty-free-image-577324858-1551472750.jpg?crop=0.84371xw:1xh;center,top&resize=480:*",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2FaYEmG95LcmLem0V_WCz3POSrQ1P_8gXPNmNxWv7EwdVNkbXJjpAl9jO8JIMkD2ZZP8&usqp=CAU",
        "https://images.unsplash.com/photo-1562008928-6185cc645f76?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGluayUyMGJlYWNofGVufDB8fDB8fA%3D%3D&w=1000&q=80",
        "https://www.travelandleisure.com/thmb/B9aLIeZ_p3C0WyKKQ8ma_izGimE=/1600x1000/filters:fill(auto,1)/Pink-Sand-Beach-Harbour-Island-The-Bahamase-PINKBEACHES1117-4e4ae197d53a4f55a863429b5390b667.jpg",
        "https://i.pinimg.com/originals/bc/52/48/bc5248497996721ce81d9430ccfb1cbb.png",
        "https://i.pinimg.com/736x/85/4d/19/854d199909a0375c60dcfa6aa225f4c6--pink-sunset-pink-beach.jpg",
      },
    },
    {
      'image':
          "https://media-cdn.tripadvisor.com/media/photo-s/17/2c/08/f9/caption.jpg",
      'name': "Koh Yao Yai",
      'detail':
          "Ko Yao Yai is a Thai island in the Andaman Sea, halfway between Phuket and Krabi. It's characterized by sandy shores, mangroves, rubber plantations and fishing villages. Beaches include Loh Paret and Loh Jark, the latter with a pier for ferries and long-tail boats. The surrounding waters are rich in coral and dotted with dive sites, like the King Cruiser Wreck near Anemone Reef, and the pinnacles of Shark Point. \n Max length: 30 km",
      'gallery': {
        "https://pix10.agoda.net/hotelImages/335179/-1/1357801386bc408525f15c80dff1c435.png?ce=0&s=1024x768",
        "https://www.jahnreisen.de/pibe-media/mwr/hotel/HKT30023-FZ_S22_13.jpg",
        "https://www.oyster.com/wp-content/uploads/sites/35/2019/05/pool-v6759879-1440-1024x683.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-s/09/00/90/d3/santhiya-koh-yao-yai.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-s/12/e9/7f/96/santhiya-koh-yao-yai.jpg",
      },
    },
    {
      'image':
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Cox%27s_Bazar_Sunset.JPG/1200px-Cox%27s_Bazar_Sunset.JPG",
      'name': "Cox's Bazar",
      'detail':
          "Cox’s Bazar is a town on the southeast coast of Bangladesh. It’s known for its very long, sandy beachfront, stretching from Sea Beach in the north to Kolatoli Beach in the south. Aggameda Khyang monastery is home to bronze statues and centuries-old Buddhist manuscripts. South of town, the tropical rainforest of Himchari National Park has waterfalls and many birds. North, sea turtles breed on nearby Sonadia Island. \n Area: 23.4 km² \n Weather: 29 °C, Wind W at 8 km/h, 81% Humidity",
      'gallery': {
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/10/e2/f8/43/longest-sea-beach-in.jpg?w=700&h=-1&s=1",
        "https://1.bp.blogspot.com/-zw3lQgq-v4s/YVsbovs5AwI/AAAAAAAABh8/UuzaqklCG7ICl-OZFHRWpD5ajLs7ZrVXgCLcBGAsYHQ/s1280/Best%2BThings%2BTo%2BDo%2Bin%2BCox%25E2%2580%2599s%2BBazar%2B.png",
        "https://media-cdn.tripadvisor.com/media/photo-s/15/99/54/30/swimming-pool.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/c/cf/Cox%27s_Bazaar_Sunset_Sep2019.jpg",
        "https://cdn.pixabay.com/photo/2018/03/20/14/00/sea-3243357__480.jpg",
        "https://wikitravel.org/upload/shared//thumb/f/fe/Sunsetatcoxsbazar.jpg/400px-Sunsetatcoxsbazar.jpg",
      },
    },
    {
      'image': "https://i.insider.com/61e9b4ecda4bc600181ab1b8?width=700",
      'name': "Maui",
      'detail':
          "Maui is an island in the Central Pacific, part of the Hawaiian archipelago. Sprawling Haleakala National Park encompasses the island’s highest peak, volcanic Haleakala, as well as the pools and waterfalls of Ohe’o Gulch, accessed via scenic, winding Hana Highway. The island's 30 miles of beaches include golden-crescent Kapalua, sheltered from strong currents by lava-rock promontories. \n Area: 1,884 km² \n Max length: 64 km \n Max width: 42 km \n Highest elevation: 10,023 ft (3055 m)",
      'gallery': {
        "https://www.gohawaii.com/sites/default/files/styles/wide_carousel_large/public/content-carousel-images/10105_mauiregionslp_VideoThumbnail.jpg?itok=vzKj-jK9",
        "https://assets3.thrillist.com/v1/image/2423365/1200x630/flatten;crop_down;webp=auto;jpeg_quality=70",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD0J1JiMs6lXICJOjQu_wmfJxKRXL7Eqi2LrHq6HIAIKVSv-RvL0fzFs1vjcqFLHRcgoc&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWVa-nPuDcZeB_oQXE2-YoRyf672J-1UWoFescMbi_otDmd5MYnmcTIP6m20hY35qA7wA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWHfPkwAI2_zDcJol0L3HDAawDFBHEMVxEfkeuXy2Y3DERPA3G9-ciWlWAR42ZkeEjt_8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgPoIuJPuDTLngaU6voi_POUK0uLluvZwHH9OgxnU6gay3lyq8cn2tSidYE_NDGGQLcFg&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsu9ADS7hIEBIR6rxXS4l0dVXflA4M5RQkGylFjWshkL8L9KcBJiwLUmEHiyDx-sY715U&usqp=CAU",
      },
    },
    {
      'image':
          "https://www.worldatlas.com/upload/df/29/12/shutterstock-490898872.jpg",
      'name': "Miami Beach",
      'detail':
          "Miami Beach is a south Florida island city, connected by bridges to mainland Miami. Wide beaches stretch from North Shore Open Space Park, past palm-lined Lummus Park to South Pointe Park. The southern end, South Beach, is known for its international cachet with models and celebrities, and its early-20th-century architecture in the Art Deco Historic district with pastel-colored buildings, especially on Ocean Drive. \n Area: 39.42 km² \n Founded: 26 March 1915 \n Elevation: 1.22 m \n Local time: Friday, 5:44 am \n Weather: 27 °C, Wind E at 2 km/h, 79% Humidity ",
      'gallery': {
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Miamibeach.jpg/800px-Miamibeach.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4PaWwSuTe8DoxX2aHJ4B9w0tef0MK8Y1_o1fxskkCj-rkCG-hBtdKL0xXNHmpMX8p6aA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8LNyqfCdymz7ypzp3L6v9o3-R5y7HotDSw4wGtuBXmSRTdAw0BzMmTdlhplHZwmzJBtk&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM5LUIKFGa89gtpx5pLlm43wcpthw1Oi5KXNFnUYwkai5xNDmfUgDUt5l_1yww64n9jk8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNHVbrgndLJe7UP7NtPeqjirxlgomHMx0C0-9jiFjwbqdmIi-5KF3jFrm5pLHHZXG3enE&usqp=CAU",
        "https://www.worldatlas.com/r/w768/upload/51/df/3a/shutterstock-1341544250.jpg",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/cd/02/3d/caption.jpg?w=500&h=300&s=1&cx=430&cy=826&chk=v1_495186e7d60a7db91378",
      },
    },
    {
      'image':
          "https://www.rd.com/wp-content/uploads/2019/10/clear-water_beaches-scaled-e1643061503702.jpg?fit=700,467",
      'name': "Clearwater Beach",
      'detail':
          "Laid-back Clearwater Beach is known for its namesake stretch of soft, white sand, which draws visitors year-round for jet-skiing, parasailing, and stand-up paddleboarding in its calm waters. Cyclists and rollerbladers glide along a winding beachfront promenade lined with casual seafood restaurants and cafes. Come sunset, Pier 60 hosts a nightly festival with street performers and craft vendors. \n Elevation: 9 m",
      'gallery': {
        "https://images.musement.com/cover/0156/24/clearwater-beach-adobestock-431618946-jpeg_header-15523519.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjZBK86YM7ZEEY0Wy8QbU3ooDwwkMtvkpbt4jFf76sAosaahWE9W0Z25sADM4VSEUCbb4&usqp=CAU",
        "https://a.cdn-hotels.com/gdcs/production177/d1249/a5ff4ac9-f813-4ecb-8dc6-59961f521979.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBTuBG__swAQbx46buHm0QYKmJ5PcSjze1gNdoXePdEw4Ud6ohbaQDiwpTHVXDGXOR-_c&usqp=CAU",
        "https://alwaysontheshore.com/wp-content/uploads/2021/01/090.jpg",
        "https://webbox.imgix.net/images/rgywmmdnxbrfmdms/fe480232-db0c-493f-8e8d-f21f542a49d7.jpg?auto=format,compress&fit=crop&crop=entropy",
        "https://live.staticflickr.com/7451/13139518484_a0cb5d9db6_b.jpg",
        "https://www.83degreesmedia.com/galleries/pier_60_by_james_branaman.jpeg",
      },
    },
    {
      'image':
          "https://www.gousa.in/sites/default/files/styles/hero_l/public/images/hero_media_image/2022-03/e572efa58c0e4bfedbae7200e7990772.jpeg?h=bcf9f3f0&itok=nDtcWSZp",
      'name': "Santa Monica State",
      'detail':
          "Santa Monica State Beach is a California State Park operated by the city of Santa Monica. \n Management: California State Parks",
      'gallery': {
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/41/76/79/caption.jpg?w=1200&h=-1&s=1",
        "https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/27/60/26.jpg",
        "https://d323urej3s5qb3.cloudfront.net/thehuntleyhotel.com-2772596881/cms/cache/v2/56412c1545930.jpg/1272x756/fit/80/2a1ac3e213e7039c8756da58a33154a6.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzhb1JBvrYPH701BeXIzEwFqNBnuPqm5qWH-BI92nriJTWFtz2Lq6hVPbmR_FYp5Ptfuc&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVOi92JAG0myHqoh0bHM3DwNuJ1nXRy8RdwSMMunfP_n1wMvIdv5Dy9jz8dboKEnhx7Xc&usqp=CAU",
        "https://media.cntraveler.com/photos/5a8db36a723a834885e1527b/16:9/w_2560,c_limit/Santa-Monica-State-Beach_GettyImages-579739546.jpg",
        "https://a.cdn-hotels.com/gdcs/production14/d1087/59523f11-21cb-4a60-8d14-c61ccac2da6e.jpg?impolicy=fcrop&w=800&h=533&q=medium",
      },
    },
    {
      'image':
          "https://media.istockphoto.com/photos/bondi-beach-picture-id908447524?k=20&m=908447524&s=612x612&w=0&h=VJR5wHRSIYUli-f0xpz0ZDb6KlfZPVpuzkSXS6JmIqE=",
      'name': "Bondi Beach",
      'detail':
          "The sweeping white-sand crescent of Bondi is one of Australia’s most iconic beaches. Reliable waves draw surfers while, nearby, hardy locals swim in the Icebergs ocean pool year-round. Trendy, health-conscious Sydneysiders head to laid-back cafes around Hall Street, while hip backpackers frequent the area's casual pubs. Walkers and joggers use the clifftop Bondi to Coogee Coastal Walk, with its dramatic scenery. \n Area: 122 ha \n Elevation: 21 m \n Location: 7 km (4 mi) E of Sydney CBD",
      'gallery': {
        "https://afar.brightspotcdn.com/dims4/default/8a609b6/2147483647/strip/true/crop/728x500+36+0/resize/660x453!/quality/90/?url=https%3A%2F%2Fafar-media-production-web.s3.amazonaws.com%2Fbrightspot%2F96%2F3a%2F0f782777468afd020670bb4894f6%2Foriginal-eb4929423cf53b1d3e55b02c14d7bd73.jpg",
        "https://int.sydney.com/sites/international/files/styles/header_slider/public/2016-12/Bondi-Beach-Sunrise-DNSW.jpg?itok=2Xl-k7Kz",
        "https://www.travellens.co/content/images/2020/08/bondi-beach.jpg",
        "https://media.destinationnsw.com.au/sites/default/files/lookatmedam/147815l3.jpg",
        "https://preview.redd.it/4wrprmq0wlr81.jpg?width=480&format=pjpg&auto=webp&s=c1728474da14613a19c719ba5a148a8b225738f9",
        "https://cdn.pixabay.com/photo/2021/04/06/19/40/bondi-beach-6157295_960_720.jpg",
      },
    },
    {
      'image':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTySBNjtDWlBmhfV1fKjWgyQ5JPoj9yxCCMtA&usqp=CAU",
      'name': "Byron Bay",
      'detail':
          "Byron Bay is a coastal town in the southeastern Australian state of New South Wales. It’s a popular holiday destination, known for its beaches, surfing and scuba diving sites. Cape Byron State Conservation Park is on a headland with a lighthouse. Between June and November, humpback whales can be spotted from headland viewpoints such as the Captain Cook Lookout. \n Elevation: 1 m \n Area: 12,406 km² \n Weather: 17 °C, Wind E at 8 km/h, 94% Humidity ",
      'gallery': {
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/34/00/72/byron-bay.jpg?w=700&h=500&s=1",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG9h_hc1tb33Wl6boOsIavATyLWDgXM4H7fYwBTHVO9IlN-qTtEjek2NG4w7Hdz3sjNQw&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgHQb_9I-3N7x3Re4F9W56T-ZbPoYJOZ14ySH4e8hiflwHZaBxbOybfMAC1eYEP9eq3I8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXOvOE12855tFSFEpAHVxFv-Ar2T_dI-tcN3esYz-ulI3bohGmNiOiMYHpn0QtZ7fYYbQ&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsAGgVL6zbmOu4c-fyjkbd0dA8gpgjGA7ks7lg4FbS6taW8wPOH2O7cqoUVBMTRHKFaYQ&usqp=CAU",
      },
    },
  ];
  List mountain = [
    {
      'image':
          "https://www.trawell.in/admin/images/upload/169351146Mount_Abu_Guru_Shikhar_Main.jpg",
      'name': "Guru Shikhar",
      'detail':
          "Guru Shikhar, a peak in the Arbuda Mountains of Sirohi district in Rajasthan, is the highest point of the Aravalli Range and Rajasthan. It rises to an elevation of 1,722 metres. \n Elevation: 1,722 m \n Prominence: 1,341 m \n District: Sirohi district",
      'gallery': {
        "https://www.trawell.in/admin/images/upload/169351146Mount_Abu_Guru_Shikhar_Main.jpg",
        "https://www.abutimes.com/wp-content/uploads/2015/12/gushikar-mount-abu.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/8/8a/Arbuda_Mountains.JPG",
        "https://www.tourmyindia.com/images/guru-shikhar1.jpg",
        "https://mountabu.tourismindia.co.in/images/places-to-visit/header/guru-shikhar-mount-abu-tourism-entry-fee-timings-holidays-reviews-header.jpg",
        "https://www.hummingbirdresorts.com/assets/images/blog/blog7-1.jpg",
        "https://www.transindiatravels.com/wp-content/uploads/guru-shikhar-1.jpg",
      },
    },
    {
      'image': "https://peakvisor.com/photo/mount-taranaki.jpg",
      'name': "Mount Taranaki",
      'detail':
          "Mount Taranaki, less commonly known as Mount Egmont, is a dormant stratovolcano in the Taranaki region on the west coast of New Zealand's North Island. It is the second highest point in the North Island, after Mount Ruapehu. The 2,518-metre mountain has a secondary cone, Fanthams Peak, 1,966 metres, on its south side. \n Elevation: 2,518 m \n Prominence: 2,308 m \n First ascent: 1839 \n Last eruption: 1854",
      'gallery': {
        "https://upload.wikimedia.org/wikipedia/commons/b/b7/Mt_Taranaki.JPG",
        "https://media.istockphoto.com/photos/view-of-mt-taranaki-new-zealand-picture-id1190530530?b=1&k=20&m=1190530530&s=170667a&w=0&h=e9FiJWMlNW3NntBFmkXiAilb3hPp_OfE3OEBLDwwaLo=",
        "https://www.discoverimages.com/p/251/mount-taranaki-egmont-taranaki-north-island-19446541.jpg",
        "https://volcano.si.edu/gallery/photos/GVP-00337.jpg",
        "https://i.guim.co.uk/img/media/ab885a519909f8d701dcd767f3817740b762df37/0_266_2000_1200/master/2000.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=2207d81765aba0a920e7065f1bb3ad22",
        "https://thumbs.dreamstime.com/b/mt-taranaki-farm-land-5099188.jpg",
      },
    },
    {
      'image':
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/04/cc/c9/fc/grand-teton.jpg?w=1200&h=-1&s=1",
      'name': "Grand Teton",
      'detail':
          "The Teton Range is a mountain range of the Rocky Mountains in North America. It extends for approximately 40 miles in a north–south direction through the U.S. state of Wyoming, east of the Idaho state line. \n Elevation: 4,199 m \n Area: 3,341 km² \n Highest point: Grand Teton \n Mountain range: Rocky Mountains",
      'gallery': {
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/04/cc/c9/fc/grand-teton.jpg?w=1200&h=-1&s=1",
        "https://lp-cms-production.imgix.net/2019-06/8e10686bea7685a55b4145d732a9a48a906c5cd1f3e6b9ebb4ca4c5b74e3946f.jpg?sharp=10&vib=20&w=1200&auto=compress&fit=crop&fm=auto&h=800",
        "https://www.getyourguide.com/magazine/wp-content/migrated-content/uploads/2021/03/TC21-MAG-TETYELL-001-1200x900.jpg",
        "https://i.ytimg.com/vi/GXZEXHZT4LM/maxresdefault.jpg",
        "https://imengine.prod.srp.navigacloud.com/?uuid=161a5b21-66a6-5810-9d16-23839fc22a76&type=primary&q=72&width=1000",
        "https://www.tripsavvy.com/thmb/XpEGcflbLCWCH_NUTnPkC7lfccI=/2700x1800/filters:fill(auto,1)/DSCF9428-043df156e4af41ffbf56bfa1033a0035.jpg",
      },
    },
    {
      'image':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtXxGY1q8xMtCOsassUzEdm02PQ349xMiqfQ&usqp=CAU",
      'name': "Denali",
      'detail':
          "Denali is the highest mountain peak in North America, with a summit elevation of 20,310 feet above sea level. With a topographic prominence of 20,194 feet and a topographic isolation of 4,621.1 miles, Denali is the third most prominent and third most isolated peak on Earth, after Mount Everest and Aconcagua. \n Elevation: 6,190 m \n Prominence: 6,144 m \n First ascent: 7 June 1913",
      'gallery': {
        "https://upload.wikimedia.org/wikipedia/commons/9/91/Wonder_Lake_and_Denali.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcSZ0aoRVUkm9cO0FHDs67KpnvEqR9In4MbQx4xKH6tk4IcLb8HXFKVPhr5jaBapcc-v4&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpDKabqbm5yPJL0RT0RpIgq1wqbzpLFmGcuRbtPUZGjapDK0Gqvvk2DtRUqedo7v4KMd0&usqp=CAU",
        "https://res.cloudinary.com/dtpgi0zck/image/upload/s--5Pb3YX9z--/c_fill,h_580,w_860/v1/EducationHub/photos/mount-denali-cloud.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeEsZQql6i7OBdGUVr2xm9PLQiKRi7GEXsvIdfPwzhrinawYruPjgnevyFEABCIkvkEUE&usqp=CAU",
        "https://www.nps.gov/dena/learn/historyculture/images/denali.jpg?maxwidth=1200&autorotate=false",
      },
    },
    {
      'image':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS60KPkfAtD4UPJXW3d6oBBxMpEeRExLH-pag&usqp=CAU",
      'name': "Shkhara",
      'detail':
          "Shkhara is the highest point in the nation of Georgia It is located near the Russian-Georgian border, in Russia's Kabardino-Balkaria region on the northern side, and the Svaneti region of Georgia in the south.\n Elevation: 5,193 m \n First ascent: 1888 \n Prominence: 1,357 m",
      'gallery': {
        "https://i.ytimg.com/vi/OC2j7j4Qazs/maxresdefault.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKM7tSImwANa25jhzjBjSeZOYAepe4QiTgJA&usqp=CAU",
        "https://alexclimb.com/_data/cat/157/IMG_3156.jpg",
        "https://image.shutterstock.com/image-photo/ushguli-village-near-highest-georgian-260nw-2194124103.jpg",
        "https://st.focusedcollection.com/13397678/i/1800/focused_180916940-stock-photo-view-wildflower-meadow-shkhara-mountain.jpg",
      },
    },
    {
      'image':
          "https://i0.wp.com/handluggageonly.co.uk/wp-content/uploads/2017/08/IMG_5159-a.jpg?fit=1600%2C1066&ssl=1",
      'name': "Rainbow Mountain",
      'detail':
          "Vinicunca, or Winikunka, also called Montaña de Siete Colores, Montaña de Colores or Rainbow Mountain, is a mountain in the Andes of Peru with an altitude of 5,200 metres above sea level. \n Elevation: 5,200 m \n Location: Peru \n Mountain range: Andes",
      'gallery': {
        "https://image.cnbcfm.com/api/v1/image/106203306-1571991790927gettyimages-1095321688cropped.jpg?v=1571991897",
        "https://cdn.kimkim.com/files/a/content_articles/featured_photos/ea1db64e3b4cdca9158dbbc40fbd8f9ff0a39abf/big-e557183034d6ae13a8d949a915953061.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTv6Hk2BpXqhYlUWBfbJKm6EoVQDc-GKdA9MNdbPxZZfo-0dyAku2fRjtnlvdL9_w6JmiA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjT49epe37Q_P7Ny3acqZC42IMA-Q9AAs_SQS-J_Uhzg_g3F0TX_aH_wJEeTt1Bt2XEBs&usqp=CAU",
        "https://www.tierrasvivas.com/img/rainbow-mountains-in-cusco-195.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVbhkwh6huVf67r1N35TsgTrqQyi_sstE8fYiwoy-8U28oRNarBJKALFqD7mCBZD8uMw4&usqp=CAU",
      },
    },
    {
      'image':
          "https://www.tourmyindia.com/states/kerala/images/Anamudi-Peak-Munnar-1.jpg",
      'name': "Anamudi",
      'detail':
          "Anamudi is a mountain located in Ernakulam district and Idukki district of the Indian state of Kerala. It is the highest peak in the Western Ghats and in South India, at an elevation of 2,695 metres and a topographic prominence of 2,479 metres. \n Elevation: 2,695 m \n First ascent: 4 May 1862 \n Prominence: 2,479 m",
      'gallery': {
        "https://www.oyorooms.com/travel-guide/wp-content/uploads/2020/01/Anamudi-View-Point-1.jpg",
        "https://www.accessindiatourism.com/wp-content/uploads/2022/03/Anamudi-Peak-Banner-2.jpg",
        "https://www.munnar.holiday/munnartourism/wp-content/uploads/2019/06/anamudi-peak-munnar-kerala-1024x385.jpg",
        "https://a0.muscache.com/im/pictures/3f524723-b711-45e0-b75e-a1b66283da14.jpg?im_w=720",
        "https://media.tripinvites.com/places/munnar/chokramudi-peak/chokramudi-peak-featured.jpg",
      },
    },
    {
      'image':
          "https://www.mountainguides.com/wordpress/wp-content/uploads/2016/02/view-of-Semantri-and-Nagga-Pulu-across-the-valley.jpg",
      'name': "Sumantri",
      'detail':
          "Sumantri Peak is a sharp mountain in the western Sudirman Range. It rises 4,870 metres. The peak is approximately 2 km northeast of Carstensz Pyramid, the highest mountain of Oceania. \n Elevation: 4,870 m \n Prominence: 350 m \n First ascent: 1962",
      'gallery': {
        "https://upload.wikimedia.org/wikipedia/commons/5/5d/Sumantri_%28center%29_with_Ngga_Pulu_%28right%29_from_Carstensz_Summit_by_Christian_Stangl_flickr.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTjJ49z4imoCA6HN5FoqLvXr-rUsAD2ZgCAAXad-P_COvfKH8E7bJ-lse8bZ83FIxnaug&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmWmo9cOlx6Td17DfWxpP4Q11niz0YQjscVjuEW9dzhFZ7nVYwyD7akIzNdfmL7t43cnc&usqp=CAU",
        "https://buliran.com/wp-content/uploads/2021/10/11.-1-sumantri-250x150.jpg",
        "https://www.ispo.com/sites/default/files/styles/teaser_desktop/public/2021-09/Ngga-Pulu.jpeg?h=c673cd1c&itok=JriRyjFx",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Puncak_Jaya_icecap_1972.jpg/650px-Mapcarta.jpg",
      },
    },
    {
      'image':
          "https://lh3.googleusercontent.com/p/AF1QipOxNd0FUBLW1cjhY_CWF5FrCAjBUuc-2Ofzq0WE",
      'name': "Aoraki / Mount Cook",
      'detail':
          "Aoraki / Mount Cook is the highest mountain in New Zealand. Its height, as of 2014, is listed as 3,724 metres. It sits in the Southern Alps, the mountain range that runs the length of the South Island. A popular tourist destination, it is also a favourite challenge for mountain climbers. \n Elevation: 3,724 m \n First ascent: 25 \n December 1894 \n Prominence: 3,724 m",
      'gallery': {
        "https://www.newzealand.com/assets/Tourism-NZ/Christchurch-Canterbury/9aa11093e3/img-1536989144-436-6533-p-4AE01862-F0F6-45CC-A4A8B61D309D3D12-2544003__aWxvdmVrZWxseQo_FocalPointCropWzM1MiwxMDI0LDUzLDUwLDc1LCJqcGciLDY1LDIuNV0.jpg",
        "https://img.freepik.com/premium-photo/aoraki-mount-cook-reflected-hooker-ake-with-iceberg-aoraki-mount-cook-national-park_461746-85.jpg?w=2000",
        "https://static.horizonguides.com/images/_matrixImage/Aoraki-Mt-Cook-national-park_mt-cook-reflected-in-a-tarn.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-s/1a/65/1e/13/caption.jpg",
        "https://live.staticflickr.com/8464/8114772965_2fd1979e70_b.jpg",
      },
    },
  ];
  List history = [
    {
      'image':
          "https://th-thumbnailer.cdn-si-edu.com/NaExfGA1op64-UvPUjYE5ZqCefk=/fit-in/1600x0/filters:focal(1471x1061:1472x1062)/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/b6/30/b630b48b-7344-4661-9264-186b70531bdc/istock-478831658.jpg",
      'name': "Taj Mahal",
      'detail':
          "The Taj Mahal, is an Islamic ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra. It was commissioned in 1632 by the Mughal emperor Shah Jahan to house the tomb of his favourite wife, Mumtaz Mahal; it also houses the tomb of Shah Jahan himself. \n Construction started: 1632 \n Height: 73 m \n Architectural style: Mughal architecture",
      'gallery': {
        "https://images.unsplash.com/photo-1564507592333-c60657eea523?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dGFqJTIwbWFoYWx8ZW58MHx8MHx8&w=1000&q=80",
        "https://miro.medium.com/max/1400/1*R9K4HFA1aG6Skyfs3Ox7bw.jpeg",
        "https://lp-cms-production.imgix.net/2019-06/283389.jpg",
        "https://images.livemint.com/img/2022/08/04/1600x900/Taj-Mahal-sylwia-bartyzel-eU4pipU_8HA-unsplash_1659578942151_1659578950109_1659578950109.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1mzOna-042vBgWAFodNBC95wQ_QhJdRk79g&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG8v0QxONh_IDrFYLH72_KGQi_oko5T2FMJQ&usqp=CAU",
        "https://vid.alarabiya.net/images/2018/07/19/8c13bb26-4552-4030-a34e-11341f2281c1/8c13bb26-4552-4030-a34e-11341f2281c1.jpg?crop=4:3&width=1200",
      },
    },
    {
      'image':
          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Ankor_Wat_temple.jpg/1200px-Ankor_Wat_temple.jpg",
      'name': "Angkor Wat",
      'detail':
          "Angkor Wat is a temple complex in Cambodia and is the largest religious monument in the world, on a site measuring 162.6 hectares. \n Address: Krong Siem Reap, Cambodia \n Land area: 163 ha \n Architectural styles: Khmer (Angkor Wat style)",
      'gallery': {
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6KE4yDZbLsxdw2HE-ixV3ngHYjrZ6wjgJIqPGmWj1KJyFI-TSNMyYz1WNJFbxTLRZm-M&usqp=CAU",
        "https://i.natgeofe.com/n/ecc4af4e-7bd2-40cc-a854-62ca89d7f96b/93405.jpg?w=636&h=425",
        "https://www.lifeberrys.com/img/article/angkor-1490162835-lb.jpg",
        "https://cdn.slidesharecdn.com/ss_thumbnails/angkorwat-120604103326-phpapp01-thumbnail-4.jpg?cb=1659448889",
        "https://images.squarespace-cdn.com/content/v1/5a9df9f4a9e028af26f1eb8c/a3c79a3f-e14b-4072-b5ab-630709b58746/angkor-wat-one-day-angkor-wat-itinerary-siem-reap-one-day-1.jpg?format=1000w",
        "https://res.klook.com/image/upload/c_fill,w_750,h_500,f_auto/w_80,x_15,y_15,g_south_west,l_Klook_water_br_trans_yhcmh3/activities/oaxmwqkrbp6epksjve40.jpg",
      },
    },
    {
      'image':
          "https://media.tacdn.com/media/attractions-splice-spp-674x446/06/70/5c/4b.jpg",
      'name': "Hawa Mahal",
      'detail':
          "The Hawa Mahal is a palace in the city of Jaipur, India. Built from red and pink sandstone, it is on the edge of the City Palace, Jaipur, and extends to the Zenana, or women's chambers. \n Architectural styles: Mughal architecture, Rajput architecture \n Opened: 1799 \n Height: 15 m \n Floors: 5",
      'gallery': {
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfcdf4uL_AkihW1r2J3kPv6x7k7toSk_q1w7l3G-I2MYlLrrr_djnqPSsZAkIJX2ncNtU&usqp=CAU",
        "https://img.onmanorama.com/content/dam/mm/en/travel/travel-news/images/2020/2/6/hawa-mahal-jaipur.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxfHBdEVWVbfQFD_tSFPOHaANzx4ZDXXbDV6ZiebJyEXxFUXabJHQMbu4sWXc4kysZ-hw&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg3vf66VrtBizI4069zZbJgZ7tKlCxA_GXhg6T_6biMF8wqDBL8bNiZ25HoyYFwi-_TyA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRguXxMKsOBaxmWzas4p4FSssxt68C4mzNVWtzwHIUaAwG665-qxsigZwfbq0ey0RRIx-o&usqp=CAU",
        "https://cdn.theculturetrip.com/wp-content/uploads/2016/06/1024px-hawa_mahal_final_1.jpg",
      },
    },
    {
      'image':
          "https://bangalore247.in/wp-content/uploads/2021/03/Mysore-Palace.jpg",
      'name': "Mysore Palace",
      'detail':
          "The Mysore Palace, also known as Amba Vilas Palace, is a historical palace and a royal residence. It is located in Mysore, Karnataka. It used to be the official residence of the Wadiyar dynasty and the seat of the Kingdom of Mysore. The palace is in the centre of Mysore, and faces the Chamundi Hills eastward. \n Construction started: 1897 \n Architectural style: Indo-Saracenic architecture \n Opened: 1912",
      'gallery': {
        "https://upload.wikimedia.org/wikipedia/commons/a/a4/Mysore_Palace_Morning.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCemz0NuWvQW32PVYZtlxyP7J-dIPPM4rahmWXFxIcUeYoGkfui0Fyv27vrFtCw97qsb8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBeAcim03zD43hsH6Lb2_KkgDZKQB5Mnkyk5IlAQ2qNVAvg8X8sLTsX2Sy13ZX5-KOhG0&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl6k1a558aa4tHO-CEGmbL6iu9w4z8CnQhDttEyOwaZr7VIGiGd6qGMoOjBOZxM1eEFn8&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgVOetgSNr1EuUlGKiga_hpSmMi58HDXdz6h2kJZIJhPPDYj3Iu60MeBG-EODwH9TkIP8&usqp=CAU",
        "https://www.holidify.com/images/cmsuploads/compressed/attr_1568_20191102174918.jpg",
      },
    },
    {
      'image':
          "https://www.udaipurian.com/wp-content/uploads/2020/10/Trekking-and-Hiking-In-Kumbhalgarh-Fort.jpg",
      'name': "Kumbhalgarh Fort",
      'detail':
          "Kumbhalgarh also known as the Great Wall of India is a Mewar fortress on the westerly range of Aravalli Hills, just about 48 km from Rajsamand city in the Rajsamand district of the Rajasthan state in western India. It is located about 84 km from Udaipur. It is a World Heritage Site included in Hill Forts of Rajasthan. \n Opened: 1592 \n Function: Fortification \n Area: 268 ha (1.03 sq mi) (662 acres)",
      'gallery': {
        "https://www.tripsavvy.com/thmb/WTeNf6nzcS1x7sj704RCRBV669U=/2119x1415/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-186361655-5c1b7361c9e77c00019049d3.jpg",
        "https://images.thrillophilia.com/image/upload/s--NNVLEohB--/c_fill,h_600,q_auto,w_975/f_auto,fl_strip_profile/v1/images/photos/000/356/454/original/1601712791_Udaipur-india-shutterstock_753879010.jpg.jpg?1601712791",
        "https://pbs.twimg.com/media/E6gS7L2VUAAASSO.jpg",
        "https://c8.alamy.com/comp/M87PH7/birth-place-of-mewars-legendary-king-maharana-pratap-kumbhalgarh-fort-M87PH7.jpg",
        "https://live.staticflickr.com/1624/24716302399_d2fe861b66_b.jpg",
      },
    },
    {
      'image':
          "https://upload.travelawaits.com/ta/uploads/2021/04/c0350450cd9b145bbf27aef33d077c03504-scaled.jpg",
      'name': "Mount Rushmore",
      'detail':
          "Mount Rushmore National Memorial is a massive sculpture carved into Mount Rushmore in the Black Hills region of South Dakota. Completed in 1941 under the direction of Gutzon Borglum and his son Lincoln, the sculpture's roughly 60-ft.-high granite faces depict U.S. presidents George Washington, Thomas Jefferson, Theodore Roosevelt and Abraham Lincoln. The site also features a museum with interactive exhibits. \n Established: 3 March 1925 \n Opened: 31 October 1941 ",
      'gallery': {
        "https://media.npr.org/assets/img/2019/11/26/ap_19081671420341_wide-ea5e9a7b5fe7fad7107db1d9ff60f1c4df908935.jpg?s=1400",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3f2rbbeWMBrDXidAcSUJJWSwK0BFspVAXhy0gSNw_6H-4akKLy2e_QET30v9dmNHor-I&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTNXTvaudhri80gBFFdF4vGd9571m49nm325HZW0W9fpsm6LhWcebujzjXPhnop_1ZTHQ&usqp=CAU",
        "https://bloximages.newyork1.vip.townnews.com/kpcnews.com/content/tncms/assets/v3/editorial/a/8a/a8a19f50-0ad7-5af6-b19a-778d50bae322/5f57e06a00e58.image.jpg?resize=667%2C500",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpmYtemWmqKFsyXbPHj_jsG3OZi-1NYiR-GmXtn_mrVe8m9pT_Zd-usKmaZZvaJWM-YrE&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg0-G793PrMmFy1jXu-ddWKNhZ4wbvc5k6fQ&usqp=CAU",
      },
    },
    {
      'image':
          "https://lp-cms-production.imgix.net/2019-06/cdedbda583f96b6b827af186e4137845-fremantle-prison.jpg",
      'name': "Fremantle Prison",
      'detail':
          "Fremantle Prison, sometimes referred to as Fremantle Gaol or Fremantle Jail, is a former Australian prison and World Heritage Site in Fremantle, Western Australia. The six-hectare site includes the prison cellblocks, gatehouse, perimeter walls, cottages, and tunnels. \n Address: 1 The Terrace, Fremantle WA 6160, Australia",
      'gallery': {
        "https://lp-cms-production.imgix.net/2019-06/cdedbda583f96b6b827af186e4137845-fremantle-prison.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/4/49/FremantlePrison3Division.jpg",
        "https://www.architectureanddesign.com.au/getmedia/8c089745-d13b-45f3-908a-dfa64c9e451d/Aerial-Freo-Prison.aspx?width=600&height=450&ext=.jpg",
        "https://i.ytimg.com/vi/4j8NQbxpTb4/hqdefault.jpg",
        "https://culturalattractionsofaustralia.com/wp-content/uploads/2019/03/FREMANTLE-PRISON-small-856x500.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAFXTo6edmTJL_nnSIxGlo0fzcsIRMuvLKFQ&usqp=CAU",
        "https://www.parenthub.com.au/wp-content/uploads/147097183_freo-prison.jpg",
      },
    },
    {
      'image':
          "https://upload.wikimedia.org/wikipedia/commons/5/5c/Royal_Exhibition_Building_in_Carlton_Gardens.jpg",
      'name': "Royal Exhibition",
      'detail':
          "The Royal Exhibition Building is a World Heritage-listed building in Melbourne, Victoria, Australia, built in 1879–1880 as part of the international exhibition movement, which presented over 50 exhibitions between 1851 and 1915 around the globe. \n Located in: Carlton Gardens \n Address: 9 Nicholson St, Carlton VIC 3053, Australia \n Architectural styles: Gothic architecture, Rundbogenstil",
      'gallery': {
        "https://museumsvictoria.com.au/media/13683/000271791-30.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFHKWBEc7BXongLQjOgNczu6R1WwNuWC0XenpBy7XwdEykum3Eub1IVeZ4mVM7Wb1w5NI&usqp=CAU",
        "https://upload.wikimedia.org/wikipedia/commons/4/43/Royal_exhibition_building_tulips_straight.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfWsHJrNxyfKY6EO4OcKloNv3672ZxeLghQ1w0teoobtl9rfB-QEJ1OhEpG0SCmUuaJxw&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS452eVG7vF3xUHVmP1cL2B3IeCkhM5OpoLT7D-0g6vv0W-CceLXgqtKLgAVXzqyqbMJ9o&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgNX7rhX1CiKK7_3j_Pknm1xVdlS9FZHbNdr2CK4_8aB4h2h2DqTFq1SKAtCEV0zPjGlc&usqp=CAU",
      },
    },
    {
      'image':
          "https://www.worldatlas.com/r/w2560-q80/upload/a6/ca/87/shutterstock-1601037709.jpg",
      'name': "Stonehenge",
      'detail':
          "Stonehenge is a prehistoric monument on Salisbury Plain in Wiltshire, England, two miles west of Amesbury. It consists of an outer ring of vertical sarsen standing stones, each around 13 feet high, seven feet wide, and weighing around 25 tons, topped by connecting horizontal lintel stones. \n Address: Salisbury SP4 7DE, United Kingdom \n Materials: Sarsen, Bluestone \n Height: Each standing stone was around 13 ft (4.0 m) high",
      'gallery': {
        "https://www.worldatlas.com/r/w2560-q80/upload/a6/ca/87/shutterstock-1601037709.jpg",
        "https://ichef.bbci.co.uk/news/976/cpsprodpb/11D0C/production/_106827927_capture.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa74cS_9eC5gVlkSGg9BhLWRFzawZBri8nGg&usqp=CAU",
        "https://cdn.images.express.co.uk/img/dynamic/151/590x/secondary/Ancient-use-Experts-have-debated-what-Stonehenge-s-purpose-was-for-years-3848156.jpg?r=1641714811156",
        "https://i0.wp.com/the-past.com/wp-content/uploads/2022/02/post-1_image0-10.jpg?ssl=1",
        "https://historia-arte.com/_/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpbSI6WyJcL2FydHdvcmtcL2ltYWdlRmlsZVwvNjEwNmQxMjliYjA5My5qcGciLCJyZXNpemUsODAwIl19.fIno0m4uhWzoEVD7si3WLde0xu5rRxZP81ZzkVEQGB8.jpg",
      },
    },
  ];
  List desert = [
    {
      'image':
          "https://polarguidebook.com/wp-content/uploads/2021/07/Antarctic-Desert.jpg",
      'name': "Antarctic Desert",
      'detail':
          "Antarctica is a desert. It does not rain or snow a lot there. When it snows, the snow does not melt and builds up over many years to make large, thick sheets of ice, called ice sheets. Antarctica is made up of lots of ice in the form of glaciers, ice shelves and icebergs. Antarctica has no trees or bushes. \n Surface Area: 5,500,000 sq mi (14,244,934 sq km)",
      'gallery': {
        "https://www.auroraexpeditions.com.au/wp-content/uploads/2020/02/is-antarctica-a-dessert.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkt5LTe9BZz_GH5w3AD0EMgWGCQl_ZUbbERuc9B9T6iML20Tdy-JGL0P5uWJKdEK6iO9Y&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGUUzjIe7YV0iq_RpwH173wUQJNSg-g7YQvWdksrdr9XaorQqfR4rljBvsm-I9SFkfSas&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBSqEQKP8gBMrSu_Vt9Z3bBYeixG_YeiPaewd8XOfQ8W25P47TfXQ8oTTQ9VLLKFsGTlY&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwjoKgfFe5AQyOv1udIEkSGBfL0hWb4ofcylvJiEkDuxsVy5wb4ivQo3H6Ekr61bhSlUE&usqp=CAU",
        "https://www.universetoday.com/wp-content/uploads/2016/03/McMurdo-Station-Night-e1459363908503.jpg",
        "https://www.researchgate.net/profile/Thulani-Makhalanyane/publication/321944158/figure/fig1/AS:712444007698433@1546871296303/Antarctic-desert-soils-Ji-et-al-3-report-an-analysis-of-microbial-communities-in.png",
      },
    },
    {
      'image':
          "https://www.thoughtco.com/thmb/7SQHj6LhUitwTyxc557wXBi4OF0=/1000x1000/smart/filters:no_upscale()/SaharaDesert-58c1a5603df78c353c3d525d.jpg",
      'name': "Sahara Desert",
      'detail':
          "The Sahara is a desert on the African continent. With an area of 9,200,000 square kilometres, it is the largest hot desert in the world and the third-largest desert overall, smaller only than the deserts of Antarctica and the northern Arctic. \n Area: 9.2 million km² \n Length: 4,800 km (3,000 mi)",
      'gallery': {
        "https://www.onthegotours.com/blog/wp-content/uploads/2019/08/Oasis-over-Sand-dunes-in-Erg-Chebbi-of-Sahara-desert-in-Morocco-Africa.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgDwmHdzJL3KLFa9GQHwz-geXfjYeJnrsRXlwgS9lXfYomLdKOyhRMKIkucnwy58OVG3Q&usqp=CAU",
        "https://cdn.britannica.com/10/152310-050-5A09D74A/Sand-dunes-Sahara-Morocco-Merzouga.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8Fo90IpwrTk1xs2K3kVrIulPfebafv-P7bcHk0vHNlexhILShW5t7cUh4VCIF9mJXcLA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKVuOiBbl0ryZgfNsAVmbIqMuTwWcEb1C6eYFytYbex9p1KEEo99NDmLsgSAmiWK5KlfI&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqrWyLI_ipYJiexaG5cdyO85d1RXSoXT7UiK9XDD3EDg9_6oN987GOGwrfmtogNnWJDTw&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRH5XHmC4CBweZBv_msrqGLiD2BQY7CeE3NVcbsk2xjjx90kmRcIU2z9YW3LdVrP-Tupo&usqp=CAU"
      },
    },
    {
      'image':
          "https://media.sciencephoto.com/e6/20/02/78/e6200278-800px-wm.jpg",
      'name': "Arabian Desert",
      'detail':
          "Arabian Desert Tours & Safari, a Tourism organisation/Service provider is one of the leading full-service destination management company in the United Arab Emirates. We have our home base centrally located in Abu Dhabi. So that we can swiftly and easily attend our guests with everything they need for the perfect cruise, desert safari, or tour. We offer a comprehensive range of tourism products and services. We offer exciting and adventurous desert safari, other tours and excursions within the UAE. Visit us, as we look forward to greeting you and having the privilege of showing you more of this wonderful city and its surroundings.",
      'gallery': {
        "https://www.worldatlas.com/r/w1200/upload/66/7d/51/shutterstock-1619559943.jpg",
        "https://mybayutcdn.bayut.com/mybayut/wp-content/uploads/Arabian-Desert-Cover-20210517.jpg",
        "https://www.google.com/search?q=Arabian+Desert&tbm=isch&ved=2ahUKEwiLl9-7qvb5AhW2i9gFHRnWBPEQ2-cCegQIABAA&oq=Arabian+Desert&gs_lcp=CgNpbWcQAzIICAAQgAQQsQMyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQ6BAgAEENQgwtYgwtg3BJoAHAAeACAAZMBiAGVApIBAzAuMpgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=5xQSY8uHGLaX4t4PmayTiA8&bih=673&biw=740&rlz=1C1CHBF_enIN926IN926#imgrc=lUQBGD7vMX6azM&imgdii=qtjR8di3vSAfvM",
        "https://cdn.britannica.com/39/95539-050-CE0F264B/landscape-Riyadh-Saudi-Arabia.jpg?w=300&h=169&c=crop",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTammdeLRECiA0LtNXQm3rnQ1wch-3imqQMJBvXHnx9idtUaWMg2qQk1_XV8YCCZ-dSw_Q&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtx-p-Iy5kWX17ouorMjVreVa86y4oCEroUpyZA3j9hgt5jnFIKNw242rKJ3B5zpE2fIg&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAU0881lWnj0kBvvjlptv86lJKTFZn8koOOdYbPzTGDVckrDMyYpWtXDGHLWMPlV83o20&usqp=CAU",
      },
    },
    {
      'image':
          "https://i0.wp.com/s3.us-west-1.amazonaws.com/caching.vezzaniphotography.com/wp-content/uploads/2018/04/27220035/Death-Valley-Racetrack-Playa-4.jpg?resize=1200%2C800&ssl=1",
      'name': "Death Valley",
      'detail':
          "Death Valley is a desert valley in Eastern California, in the northern Mojave Desert, bordering the Great Basin Desert. During summer, it is one of the hottest places on Earth, along with deserts in the Middle East and the Sahara. \n Elevation: -86 m \n Lowest elevation: 86 m (Below sea level) \n Area: 3,000 square miles (7,800 km2) \n Rivers: Furnace Creek; Amargosa River",
      'gallery': {
        "https://npf-prod.imgix.net/uploads/2016020920-20shutterstock_84004441.jpg?auto=compress%2Cformat&crop=focalpoint&fit=min&fp-x=0.5&fp-y=0.5&h=900&q=80&w=1600",
        "https://i.ytimg.com/vi/nZrI14lXFHk/hqdefault.jpg",
        "https://pvtimes.com/wp-content/uploads/2022/08/16791024_web1_JUMP2.jpg?crop=1",
        "https://www.visitcalifornia.com/sites/visitcalifornia.com/files/styles/welcome_image/public/VC_DeathValleyFloraFauna_Hero_DeathValley_Stock_RF_474136334_1280x640.jpg",
        "https://img.freepik.com/free-photo/sunny-scenery-artist-drive-death-valley-national-park-california-usa_181624-34993.jpg?w=2000",
        "https://i.natgeofe.com/n/94b2bb39-7525-4c49-b7fb-8f9e02525f32/2078.jpg?w=636&h=477",
        "https://www.travelandleisure.com/thmb/68LUvgpXRDcqb-vJNowcv_wlhUY=/400x0/filters:no_upscale():max_bytes(150000):strip_icc():gifv()/north-kelbaker-seventeen-mile-point-DVRDCLOSE0822-eb0464a312f6491c982ca80546ca1d2e.jpg",
      },
    },
    {
      'image':
          "https://cdn.britannica.com/34/7934-050-B573BA76/Death-Valley-National-Park-Great-Basin-California.jpg",
      'name': "Great Basin desert",
      'detail':
          "The Great Basin Desert is part of the Great Basin between the Sierra Nevada and the Wasatch Range. \n Biome: Deserts and xeric shrublands \n Habitat loss: 90% \n Bird species: 204 \n Mammal species: 105",
      'gallery': {
        "https://cdn.britannica.com/34/7934-050-B573BA76/Death-Valley-National-Park-Great-Basin-California.jpg",
        "https://www.desertusa.com/grb/grbphotos/Gnarly_Bristlecone_Pine.jpg",
        "https://image.shutterstock.com/image-photo/dusting-snow-great-basin-high-260nw-1028700100.jpg",
        "https://www.worldatlas.com/r/w768/upload/be/fd/f8/great-basin-desert-winter-utah-us-n-mrtgh.jpg",
        "https://www.worldatlas.com/r/w768/upload/4e/bd/0f/lake-lahontan-great-basin-desert-nevada-us-dominic-gentilcore-phd.jpg",
        "https://pbs.twimg.com/media/DllDPLjW4AAFU7r.jpg",
      },
    },
    {
      'image':
          "https://cff2.earth.com/uploads/2019/08/20134902/Irregular-Sonoran-monsoon-highlights-danger-of-always-blaming-climate-change.jpg",
      'name': "Sonoran Desert",
      'detail':
          "The Sonoran Desert is a North American desert and ecoregion that covers large parts of the southwestern United States, as well as the northwestern Mexican states of Sonora, Baja California, and Baja California Sur. It is the hottest desert in both Mexico and the United States. \n Area: 222,998 km² \n Biome: Deserts and xeric shrublands \n Bird species: 246 \n Rivers: Colorado River",
    },
    {
      'image': "https://static.toiimg.com/photo/68427211.cms",
      'name': "Thar Desert",
      'detail':
          "The Thar Desert, also known as the Great Indian Desert, is an arid region in the north-western part of the Indian subcontinent that covers an area of 200,000 km² and forms a natural boundary between India and Pakistan. It is the world's 20th-largest desert, and the world's 9th-largest hot subtropical desert. \n Area: 238,254 km² \n Borders: Northwestern thorn scrub forests and Rann of Kutch seasonal salt marsh \n Biome: Deserts and xeric shrublands",
    },
    {
      'image':
          "https://www.lehladakhindia.com/blog/wp-content/uploads/2016/01/LLI-nubra-valley.jpg",
      'name': "ladakh cold desert",
      'detail':
          "Ladakh is a cold desert lying in the Great Himalayas, on the eastern side of Jammu and Kashmir. The Karakoram Range in the north and the Zanskar mountains in the south enclose it. Several rivers flow through Ladakh, Indus being the most important among them. The rivers form deep valleys and gorges.",
    },
    {
      'image':
          "http://cdn.cnn.com/cnnnext/dam/assets/180706100551-04-great-rann-of-kutch.jpg",
      'name': "Rann of Kutch",
      'detail':
          "The Great Rann of Kutch is a salt marsh in the Thar Desert in the Kutch District of Gujarat, India. It is about 7500 km² in area and is reputed to be one of the largest salt deserts in the world. This area has been inhabited by the Kutchi people. ",
    },
  ];
  int selected = 0;
  List<String> catG = [
    "HillStations",
    "Beach",
    "History",
    "Desert",
    "WildLife",
    "Waterfall",
    "Educational"
  ];

  List<List<QueryDocumentSnapshot<Map<String, dynamic>>>> categoryList = [];

  @override
  void initState() {
    selected = widget.index;
    getCategory();
    super.initState();
  }

  void getCategory() {
    for (var e in catG) {
      categoryList.add(widget.dataList
          .where((element) => element['category'] == e)
          .toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Category")),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Container(
            width: 450,
            height: 35,
            margin: const EdgeInsets.only(left: 5),
            child: ListView.builder(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 85,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: selected == index ? Colors.lightBlue : null,
                    ),
                    child: Center(
                      child: Text(
                        catG[index],
                        style: TextStyle(
                          color: selected == index ? Colors.white : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: categoryList[selected].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, i) {
                  final data = categoryList[selected][i];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => Package(
                                    data: data,
                                  )))
                          .whenComplete(() => setState(() {}));
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              image: NetworkImage(data['images'][0]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.3)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                tileMode: TileMode.mirror),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 10,
                          child: GestureDetector(
                            onTap: () async {
                              await Favourite.updateFavourite(data.id);
                              setState(() {});
                            },
                            child: Container(
                              child: UserProfile.favouriteList.contains(data.id)
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(Icons.favorite_border,
                                      color: Colors.white),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 5,
                          bottom: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Icon(
                                    Icons.location_on_sharp,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 20,
                                    child: Text(
                                      data['name'],
                                      maxLines: 1,
                                      // overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: const [
                              //     SizedBox(
                              //       width: 45,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
