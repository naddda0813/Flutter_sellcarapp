import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> parent of 03bead4 (commit)
      body: Center(
        child: Column(
          children: [
            const Text(
              'COMMUNITY',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
<<<<<<< HEAD
=======
=======
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: comList.isEmpty
              ? const Text('No Data here')
              : ListView.builder(
                  itemCount: comList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Static.content = comList[index]['content'];
                        Static.nickname = comList[index]['nickname'];
                        Static.title = comList[index]['title'];
                        Static.createDate = comList[index]['createAt'].toString(); 
                        //Static.deleteDate = comList[index]['deleteAt'].toString(); 
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detailcommunity(
                                    pnum: comList[index]['pnum'],
                                    title: comList[index]['title'],
                                    content: comList[index]['content'],
                                    createAt: comList[index]['createAt'],
                                    nickname: comList[index]['nickname'],
                                ))).then((value) => rebuildData());
                      },
                      child: Card(
                        color: Colors.grey[350],
                        child: Row(
                          children: [
                            //if(comList[index]['deleteAt'].isEmpty)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,3,180,3),
                                  child: Text(
                                    comList[index]['nickname'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 250,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(12, 3, 180, 3),
                                    child: Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        text: TextSpan(
                                          text: comList[index]['title'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ].toList(),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Column(
                                children: [
                                  Text(comList[index]['createAt'].toString().substring(0,10)),
                                  Text(comList[index]['createAt'].toString().substring(11,16))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 4, 31, 56),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Addcommunity(),
>>>>>>> yejin
>>>>>>> parent of 03bead4 (commit)
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
=======

  // Functions
    getJSONData() async {
    var url =
        Uri.parse('http://localhost:8080/Flutter/sell_car/boardmain.jsp');
    var response = await http.get(url);
    setState(() {
      if(response.body.isNotEmpty){
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      List result = dataConvertedJSON['results'];
      comList.addAll(result);
      }
    });

    return true;
  }

  rebuildData() {
    setState(() {
      comList = [];
      getJSONData();
    });
  }
>>>>>>> parent of 03bead4 (commit)
}
