import 'package:flutter/material.dart';

class Exercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            ExpansionTile(
              title: Text(
                'Chest',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: [
                ExerciseCard('Barbell Bench Press',
                    'https://cdn.mos.cms.futurecdn.net/pLaRi5jXSHDKu6WRydetBo-650-80.jpg.webp'),
                ExerciseCard('Dumbbell Bench Press',
                    'https://bod-blog-assets.prod.cd.beachbodyondemand.com/bod-blog/wp-content/uploads/2016/09/26175512/dumbbell-bench-press-sagi-kalev.jpg'),
                ExerciseCard('Incline Bench Press',
                    'https://imgs.search.brave.com/OAeStZVXBpJRIju4VbEYL9P6TPQT9nU89GOohFmXfYM/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9iYXJi/ZW5kLmNvbS93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyMi8wMi9z/aHV0dGVyc3RvY2tf/MjI2NDYyOTE4Lmpw/Zw'),
                ExerciseCard('Chest Flyes',
                    'https://imgs.search.brave.com/6xHtxFwHyn32Jb4oGedZeh3jWvQq_36QoACg_A2YsGA/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9oaXBz/LmhlYXJzdGFwcHMu/Y29tL2htZy1wcm9k/L2ltYWdlcy9hbi1h/c2lhbi1tYW4taW4t/YS1ibHVlLXRhbmst/dG9wLWRvZXMtYS1z/ZXQtb2Ytcm95YWx0/eS1mcmVlLWltYWdl/LTE2NTE2NzIyODIu/anBnP2Nyb3A9MXh3/OjAuODQzNzV4aDtj/ZW50ZXIsdG9wJnJl/c2l6ZT0xMjAwOio'),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Back',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: [
                ExerciseCard('Deadlifts',
                    'https://imgs.search.brave.com/lHSEPxwvln0OhobSZ6_WJnfNYDMShC_Jq55WPs-KTtA/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9icmVh/a2luZ211c2NsZS5j/b20vd3AtY29udGVu/dC91cGxvYWRzLzIw/MjIvMDQvc2h1dHRl/cnN0b2NrXzIzMzg3/MzY1Ni5qcGc'),
                ExerciseCard('Lat Pulldowns',
                    'https://imgs.search.brave.com/E1AmiaCvaHDLDwBA7a1AbloKrt4vnXiEYLXyNvnaICE/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9iYXJi/ZW5kLmNvbS93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyMS8xMi9z/aHV0dGVyc3RvY2tf/MTQ3NTAxMTM0My0x/LmpwZw'),
                ExerciseCard('T-Bar Rows',
                    'https://imgs.search.brave.com/XsGn2VEgNwotIAbBq0PjQ4pOuXRkm1iFTMdO1C7otNI/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMuc3F1YXJlc3Bh/Y2UtY2RuLmNvbS9j/b250ZW50L3YxLzU3/NTBkNTEyOWY3MjY2/MmQ2NjQ0ODAyOC8x/NTAyODY0MDI1ODMy/LU1EQ0kyMTk5T05L/WFk1MFZDMU5aL1Qt/QmFyK1Jvdy5qcGc'),
                ExerciseCard('Seated Cable Rows',
                    'https://imgs.search.brave.com/6qLatHLHdjmxdyZ6dJzNAr38VkCHLuhikD_JQReIxWY/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9maXRu/ZXNzcHJvd29ya291/dC5jb20vd3AtY29u/dGVudC91cGxvYWRz/LzIwMjEvMDYvU2Vh/dGVkLWNhYmxlLXJv/dy1hbHRlcm5hdGl2/ZS1zY2FsZWQuanBn'),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Shoulders',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: [
                ExerciseCard('Military Press',
                    'https://imgs.search.brave.com/oxLjRVgnelyO6BxD8unOBnjtLjQH8gYDLUsyIradoqs/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9sZWdp/b25hdGhsZXRpY3Mu/Y29tL3dwLWNvbnRl/bnQvbWZsLXVwbG9h/ZHMvMjAxOS8wMi9o/b3ctdG8taW5jcmVh/c2UtbWlsaXRhcnkt/cHJlc3MuanBn'),
                ExerciseCard('Lateral Raises',
                    'https://imgs.search.brave.com/J-q9gEcWB5mu5PW0iAfeZRG32gHPhu4MI52Chbz-r9E/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/dGhldHJlbmRzcG90/dGVyLm5ldC93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyMi8wNi9M/YXRlcmFsLVJhaXNl/LTMuanBn'),
                ExerciseCard('Face Pulls',
                    'https://imgs.search.brave.com/tfRa8OqOgh1z55NB4lWgiQwLKGDPr-OBOAApNkCmNdY/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4u/bW9zLmNtcy5mdXR1/cmVjZG4ubmV0LzNa/QUVYY2Q3Y0EzVzJm/TXJWUVk5RUUtMzIw/LTgwLmpwZw'),
                ExerciseCard('Upright Rows',
                    'https://imgs.search.brave.com/0fVhNQMmQNnqjowznozaYKVKCKJZH4lcq73yIXaZCo4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9wb3dl/cmxpZnRpbmd0ZWNo/bmlxdWUuY29tL3dw/LWNvbnRlbnQvdXBs/b2Fkcy8yMDIyLzA5/L3VwcmlnaHQtcm93/cy5qcGc'),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Arms',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: [
                ExerciseCard('Barbell Bicep Curls',
                    'https://imgs.search.brave.com/TVQ1PDD3_ISFzmgLvVta-Q3rIKYBU-BPkaqtCYUHto4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/bXVzY2xlYW5kZml0/bmVzcy5jb20vd3At/Y29udGVudC91cGxv/YWRzLzIwMTgvMDEv/QmFyYmVsbC1CaWNl/cHMtQ3VybC1Cb2R5/YnVpbGRlci0xMTA5/LmpwZz93PTExMDkm/aD02MTQmY3JvcD0x/JnF1YWxpdHk9ODYm/c3RyaXA9YWxs'),
                ExerciseCard('Tricep Rope Pushdowns',
                    'https://imgs.search.brave.com/VR-bk0rVKolwN97n7ehCkBEID1mm1y8iBKe3rwIvRl8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4u/c2hvcGlmeS5jb20v/cy9maWxlcy8xLzE2/MzMvNzcwNS9maWxl/cy90cmljZXBfcHVz/aGRvd25fdmFyaWF0/aW9uc183MDVkM2Fl/Ny00NWI1LTRhODUt/ODFjYi1kMDM1YzQy/ZTI1YWZfNDgweDQ4/MC5qcGc_dj0xNjQy/NTcxNTg0'),
                ExerciseCard('Preacher Curls',
                    'https://imgs.search.brave.com/D5rryEAl0cGeP9LCiIc-5NFMWGTQYwLgxHkFyI2yBjU/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9ibG9n/LnNxdWF0d29sZi5j/b20vd3AtY29udGVu/dC91cGxvYWRzLzIw/MTkvMDUvUEMyLmpw/Zw'),
                ExerciseCard('Skull Crushers',
                    'https://imgs.search.brave.com/KVn1r66hUkw7iI4nWXk9p_A76TAOlZTMxaymIisByUw/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9oaXBz/LmhlYXJzdGFwcHMu/Y29tL2htZy1wcm9k/L2ltYWdlcy9oZG0x/MTk5MThtaDE2MDk0/LTE1NDQwMjU1ODku/cG5nP2Nyb3A9MXh3/OjAuODQzNzV4aDtj/ZW50ZXIsdG9wJnJl/c2l6ZT0xMjAwOio'),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Legs',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: [
                ExerciseCard('Barbell Squats',
                    'https://imgs.search.brave.com/5cIGHmCmMucNZ7y5GsyEiCgYL1qtNou5KUhkM7nUiZ0/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4u/bW9zLmNtcy5mdXR1/cmVjZG4ubmV0Lzc3/WnNLdDhjTXJucXFO/c1FuaFpzeTctMzIw/LTgwLmpwZw'),
                ExerciseCard('Leg Press',
                    'https://imgs.search.brave.com/KdK3mYt7heGVqxWWCINi8vZMWTzyDd22YJNrEewtyS4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAxLzE5LzQzLzk4/LzM2MF9GXzExOTQz/OTgyOV9pOVZyQ0U2/ZDlaRnNBWFlRVkFo/ajhsSzVKclRDM2lq/Yi5qcGc'),
                ExerciseCard('Lunges',
                    'https://imgs.search.brave.com/xn3Ak8YbdYq0k8oy3OgXe-88Wt6akavBpmSOnyUO8KY/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTE0/MDEwOTgwMi9waG90/by9taWQtYWR1bHQt/bWFuLWRvaW5nLWx1/bmdlcy5qcGc_cz02/MTJ4NjEyJnc9MCZr/PTIwJmM9Z0xzYzFk/UW1vOFN6S0xrT01x/dWRPTU1xUkpEZ1dj/dkhQdUlBaC0wTHVM/az0'),
                ExerciseCard('Leg Extensions',
                    'https://imgs.search.brave.com/87zlGZ7v4bOrxyJUg7XXWeuMMQ5icy40RK228hEmIms/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudGhjZG4uY29t/L2ltYWdlcy92Mi93/cC1jb250ZW50L3Vw/bG9hZHMvc2l0ZXMv/NDc4LzIwMTYvMDgv/MjgwMjQ4NDkvbGVn/ZXh0ZW5zaW9uLmpw/Zz93aWR0aD03MDA'),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Core',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: [
                ExerciseCard('Planks',
                    'https://imgs.search.brave.com/cmpsgsnNhoGj3KmGeF5Mawidkha3BvCo5pceNvumetE/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTMx/OTIyMTk2OS9waG90/by9zaG90LW9mLWEt/eW91bmctbWFuLWRv/aW5nLXBsYW5rcy1k/dXJpbmctaGlzLXdv/cmtvdXQtcm91dGlu/ZS1hdC10aGUtZ3lt/LmpwZz9zPTYxMng2/MTImdz0wJms9MjAm/Yz0zaVJHMTZfb1Jj/Z2stdHU5Zm5xdGQy/NU15eHF6S21zendy/eElfdUJiZFBBPQ'),
                ExerciseCard('Cable Crunches',
                    'https://imgs.search.brave.com/ONL69aCymKEE6BFV1hQjHYpNDK59WxezN5ss6qvyXB4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9maXRs/aWZlZmFuYXRpY3Mu/Y29tL3dwLWNvbnRl/bnQvdXBsb2Fkcy8y/MDIwLzA1L0NhYmxl/LUNydW5jaGVzLUd1/aWRlLTc4MHg0NzAu/anBn'),
                ExerciseCard('Hanging Leg Raises',
                    'https://imgs.search.brave.com/sm0x1GkxDupzK3GfdUTbYwoCIMl27PuxPfPq3JRO74s/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/ZG1vb3NlLmNvbS9j/ZG4vc2hvcC9hcnRp/Y2xlcy9NYWluX0lt/YWdlXzc4YWFhZDQ4/LTc5MTQtNGJlMi1i/YzJhLWU2Nzk0YTAx/NDFkNC5qcGc_dj0x/NjcwNjgwNjM3'),
                ExerciseCard('Russian Twists',
                    'https://imgs.search.brave.com/qXOVIcGmuDACc3wZgLG0ZVi4CZ4mSmbCRpNxltv2OS8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9oaXBz/LmhlYXJzdGFwcHMu/Y29tL2htZy1wcm9k/L2ltYWdlcy9ydHdp/c3QxLWpwZy0xNTcw/NjM2NDIwLmpwZz9j/cm9wPTF4dzowLjg0/Mzc1eGg7Y2VudGVy/LHRvcCZyZXNpemU9/MTIwMDoq'),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Cardio',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: [
                ExerciseCard('Treadmill Running',
                    'https://imgs.search.brave.com/GxGWRWRfqa7stsV26tCDlu5zDwfUv1htT_COOUj9RgA/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNTE4/NjU2ODE3L3Bob3Rv/L2hlYWx0aHktbWFu/LXJ1bm5pbmctb24t/dHJlYWRtaWxsLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz1I/eEN3bWUwRjE2OFlV/MkJqV3ZFN1hkM2Fn/eElaOE4ySFpEUWRq/RTZZRGRjPQ'),
                ExerciseCard('Elliptical Machine',
                    'https://imgs.search.brave.com/p6ZvZAh6qdHoGTawxPnjGBQR3d98iwvp1M0tUI1gg7Y/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvOTM5/MDg3ODMvcGhvdG8v/YWZyaWNhbi1tYW4t/d29ya2luZy1vdXQt/b24tZWxsaXB0aWNh/bC1tYWNoaW5lLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz1n/cjZraHNGWlJ2RTcz/MUx1Mm1TVVZoUmxP/ODdfakFiNXNzMXJL/ckZFSHBFPQ'),
                ExerciseCard('Stationary Bike',
                    'https://imgs.search.brave.com/dybLZ0-yqeRlna3RhOkTk9qLJlI3wQi6CMcd8uPzPBU/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4u/bW9zLmNtcy5mdXR1/cmVjZG4ubmV0L0NX/a3IyeWZrVm1rb3JY/WVlTV0d3R0UtMzIw/LTgwLmpwZw'),
                ExerciseCard('Stair Climber',
                    'https://imgs.search.brave.com/vcMgoB--BIY9p8l40_VOo3bdHuhQVbaq0tExtaciU_A/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9ibG9n/LmZpdGJpdC5jb20v/d3AtY29udGVudC91/cGxvYWRzLzIwMTgv/MDEvMDExNi5TdGFp/ci1DbGltYmVyLVdv/cmtvdXRzLUJsb2ct/SGVyby5qcGc'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String exercise;
  final String imageUrl;

  ExerciseCard(this.exercise, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: Text(
              exercise,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Image.network(
            imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: Exercises()));
}
