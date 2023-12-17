import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int coin = 0;

  late BannerAd _bannerAd;
  bool _isBannerReady = false;

  late InterstitialAd _interstitialAd;
  bool _isInterstitialReady = false;

  late RewardedAd _rewardedAd;
  bool _isRewardedReady = false;

  bool _isPaid = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    // _loadInterstitialAd();
    // _loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AdMob"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.monetization_on_rounded, size: 50,),
                Text(coin.toString(), style: const TextStyle(fontSize: 50),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _loadInterstitialAd();
                  if (_isInterstitialReady) {
                    _interstitialAd.show();
                  }
                }, 
                child: const Text("Interstitial Ads")   // iklan layar penuh
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _loadRewardedAd();
                  if (_isRewardedReady) {
                    _rewardedAd.show(
                      onUserEarnedReward: (AdWithoutView ad, RewardItem item) {
                        // PENTING: memastikan pengguna diberi hadiah karena telah selesai menonton video
                        setState(() {
                          coin += 1;
                        });
                      }
                    );
                  }
                }, 
                child: const Text("Rewarded Ads")
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isPaid
                ? ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isPaid = false;
                    });
                  }, 
                  child: const Text("Show Banner Ads")
                )
                : Tooltip(
                  message: coin<3? "Coin Anda tidak cukup! (min. \$3)" : "Tekan untuk menghapus iklan!",
                  child: ElevatedButton(
                    onPressed: coin<3? null : () {
                      payToCloseAd();
                    }, 
                    child: const Text("Remove Ads")
                  ),
                ),
            ),

            Expanded(  // banner ad: iklan kecil, biasa di bawah/ di atas layar; ttp stay disono
              child: _isBannerReady && !_isPaid? 
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd,),
                  ),
                ) : const SizedBox()
            ),
          ],
        ),
      ),
    );
  }
  
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,  // menentukan ukuran banner, gunakan AdSize.banner
      adUnitId: "ca-app-pub-3940256099942544/6300978111",   // nilai unik yang digunakan untuk menandakan sebuah iklan yang di daftarkan pada adMob; krn masi development, gunakan id "ca-app-pub-3940256099942544/6300978111" khusus developer
      listener: BannerAdListener(  // mendengarkan event yang diberikan oleh adMob
        onAdLoaded: (_) {
          setState(() {
            _isBannerReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerReady = false;
          ad.dispose();
        }
      ),
      request: const AdRequest(),  // berisi informasi penargetan (filter iklan) yang digunakan untuk mengambil iklan
    );
    _bannerAd.load();
  }
  
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",   // krn masi development, gunakan id "ca-app-pub-3940256099942544/1033173712" 
      request: const AdRequest(), 
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              // untuk menjalankan sebuah perintah ketika iklan ditutup oleh pengguna. 
              // biasanya digunakan untuk melanjutkan navigasi ke layar berikutnya.
              print("Close Interstitial Ad");
            }
          );
          setState(() {
            _isInterstitialReady = true;
            _interstitialAd = ad;            
          });
        }, 
        onAdFailedToLoad: (err) {
          ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(const SnackBar(content: Text("Tidak ada iklan untuk saat ini",)));
          _isInterstitialReady = false;
          _interstitialAd.dispose();
        }
      )
    );
  }
  
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: "ca-app-pub-3940256099942544/5224354917",  // krn masi development, gunakan id "ca-app-pub-3940256099942544/5224354917" khusus developer
      request: const AdRequest(), 
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _isRewardedReady = false;
              });
              _loadRewardedAd();
            }
          );
          
          setState(() {
            _isRewardedReady = true;
            _rewardedAd = ad;
          });
        }, 
        onAdFailedToLoad: (err) {
          ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(const SnackBar(content: Text("Tidak ada iklan untuk saat ini")));
          _isRewardedReady = false;
          _rewardedAd.dispose();
        }
      )
    );
  }

  void payToCloseAd() {
    setState(() {
      coin = coin - 3;
      _isPaid = true;
    });
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Text("Pembayaran coins \$3 diterima. Iklan Banner berhasil dihilangkan!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text("OK")
            )
          ]
        );
      }
    );
  }
}