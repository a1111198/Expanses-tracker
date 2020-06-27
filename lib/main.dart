/////import 'dart:io';
import "dart:math";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/cupertino.dart";

void main() {
  //SystemChrome.setPreferredOrientations(
  //[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(Manager());
}

class TransectionItem extends StatefulWidget {
  final Transection transection;
  final Function deletefun;
  TransectionItem(
      {Key key, @required this.transection, @required this.deletefun})
      : super(key: key);

  _TransectionItemState createState() => _TransectionItemState();
}

class _TransectionItemState extends State<TransectionItem> {
  // for stateful widget use widget.transection to access transection
  Color _colorvar;
  @override
  void initState() {
    const available = [Colors.red, Colors.purple, Colors.blue, Colors.green];
    _colorvar = available[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        child: ListTile(
          contentPadding: EdgeInsets.all(3),
          leading: CircleAvatar(
              backgroundColor: _colorvar,
              radius: 25,
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(
                      child: Text(
                          '${widget.transection.amount.toStringAsFixed(0)}')))),
          title: Text(widget.transection.title,
              style: Theme.of(context).textTheme.headline6),
          subtitle: Text(
              widget.transection.date.toString().substring(8, 10) +
                  '-' +
                  widget.transection.date.toString().substring(5, 7) +
                  '-' +
                  widget.transection.date.toString().substring(0, 4),
              style: TextStyle(color: Colors.grey)),
          trailing: MediaQuery.of(context).size.width > 400
              ? FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text("DELETE"),
                  onPressed: () => widget.deletefun(widget.transection.id))
              : IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.deletefun(widget.transection.id);
                  },
                  color: Colors.grey,
                ),
        ));
  }
}

class Transection {
  String id;
  String title;
  double amount;
  DateTime date;
  Transection(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}

class TransectionList extends StatelessWidget {
  final List<Transection> transections;
  final Function deletefun;
  TransectionList(this.transections, this.deletefun);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: transections.length == 0
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Container(
                    height: constraints.maxHeight,
                    child: Image.network(
                      'https://document-export.canva.com/DAD4Tq-IcSU/9/thumbnail/0001-5814505078.png',
                    ));
              })
            : ListView(
                children: transections
                    .map((tx) => TransectionItem(
                        transection: tx,
                        key: ValueKey(tx.id),
                        deletefun: deletefun))
                    .toList(),
              ));
    /*ListView.builder(
                itemBuilder: (context, index) {
                  return Card( elevation:5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                              '${transections[index].amount.toStringAsFixed(0)}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.all(5),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(transections[index].title,
                                style: Theme.of(context).textTheme.title),
                            Text(
                                transections[index]
                                    .date
                                    .toString()
                                    .substring(0, 10),
                                style: TextStyle(color: Colors.grey))
                          ],
                        )
                      ],
                    ),
                  )

                      TransectionItem(key: UniqueKey(),
                          transection: transections[index],
                          deletefun: deletefun);
                },
                itemCount: transections.length,
              ));*/
  }
}

/*class AllTransection extends StatefulWidget {
  @override
  AllTransectionState createState() => AllTransectionState();
}

class AllTransectionState extends State<AllTransection> {
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransection(_addnewtransection),
        
      ],
    );
  }
}
*/
class NewTransection extends StatefulWidget {
  final Function addtrans;
  NewTransection(this.addtrans) {
    print("new transection constructer is called");
  }
  NewTransectionState createState() {
    print('create state is called');
    return NewTransectionState();
  }
}

class NewTransectionState extends State<NewTransection> {
  final _textcontrol = TextEditingController();
  final _amountcontrol = TextEditingController();
  DateTime _selecteddate;
  NewTransectionState() {
    print("constructer in state");
  }
  @override
  void initState() {
    print("ininstartee");
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransection oldwidget) {
    print("didUdateWidget is called ");
    super.didUpdateWidget(oldwidget);
  }

  @override
  void dispose() {
    print('disose method is called');
    super.dispose();
  }

  void _submitdata() {
    if (_textcontrol.text == null ||
        double.parse(_amountcontrol.text) < 0 ||
        _selecteddate == null) {
      return;
    }
    widget.addtrans(
        _textcontrol.text, double.parse(_amountcontrol.text), _selecteddate);
    Navigator.of(context).pop();
  }

  void _datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selecteddate = pickedDate;
      });
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    final toc = Theme.of(context);
    return Card(
        child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: _textcontrol,
                      onSubmitted: (_) => _submitdata(),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "Amount"),
                      controller: _amountcontrol,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitdata(),
                    ),
                    Container(
                        child: Row(
                      children: <Widget>[
                        Text(_selecteddate == null
                            ? "No Chosen Date"
                            : _selecteddate.toString().substring(8, 10) +
                                '-' +
                                _selecteddate.toString().substring(5, 7) +
                                '-' +
                                _selecteddate.toString().substring(0, 4)),
                        IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              color: toc.primaryColor,
                            ),
                            onPressed: () => {_datepicker()})
                      ],
                    )),
                    FlatButton(
                        color: toc.primaryColor,
                        textColor: toc.textTheme.button.color,
                        child: const Text(
                          "Add Record",
                        ),
                        onPressed: () {
                          _submitdata();
                        })
                  ],
                ))));
  }
}

class Manager extends StatelessWidget {
  //String titletext;
  //String amounttext;

  @override
  Widget build(BuildContext context) {
    return /*Platform.isIOS ? CupertinoApp(
      title: "Personal Expanses",
      theme: CupertinoThemeData( 
          ),
      home: MyHomePage()
    )
      : */
        MaterialApp(
      title: "Personal Expanses",
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purpleAccent,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transection> transections = [
    /*Transection(
      id: '1',
      title: "birthday party",
      amount: 1500,
      date: DateTime.now(),
    ),
    Transection(
        id: '2',
        title: "domain(grapevinecollege.com)",
        amount: 470,
        date: DateTime.now())*/
  ];
  void _addnewtransection(String titlearg, double amountarg, DateTime datearg) {
    final newtrans = Transection(
        title: titlearg,
        id: DateTime.now().toString(),
        date: datearg,
        amount: amountarg);
    setState(() {
      transections.add(newtrans);
      transections.sort((b, a) => a.date.compareTo(b.date));
    });
  }

  void _startaddnewtrans(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransection(_addnewtransection);
        });
  }

  void deletefun(String id) {
    setState(() {
      transections.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  bool _showchart = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transection> get recenttransection {
    return transections.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<Widget> _buildLandscape(MediaQueryData mq, AppBar appbarvar,
      Widget _trlcontainer, Widget _switch) {
    return [
      _switch,
      _showchart
          ? Container(
              height: (mq.size.height -
                      mq.padding.top -
                      appbarvar.preferredSize.height) *
                  0.5,
              child: Chart(recenttransection))
          : _trlcontainer,
    ];
  }

  List<Widget> _buildPortait(
      MediaQueryData mq, AppBar appbarvar, Widget _trlcontainer) {
    return [
      Container(
          height: (mq.size.height -
                  mq.padding.top -
                  appbarvar.preferredSize.height) *
              0.3,
          child: Chart(recenttransection)),
      _trlcontainer
    ];
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appbarvar =
        /*Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("personal Expenses"),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                  onTap: () => _startaddnewtrans(context),
                  child: Icon(CupertinoIcons.add))
            ]),
          )
        : */
        AppBar(
      centerTitle: true,
      title: const Text("Personal Expenses"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            size: 50,
          ),
          onPressed: () => _startaddnewtrans(context),
        )
      ],
    );
    final _switch = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("show Chart"),
      Switch.adaptive(
        value: _showchart,
        onChanged: (val) {
          setState(() {
            _showchart = val;
          });
        },
      )
    ]);
    final mq = MediaQuery.of(context);
    final islandscape = mq.orientation == Orientation.landscape;
    final _trlcontainer = Container(
        height:
            (mq.size.height - mq.padding.top - appbarvar.preferredSize.height) *
                0.7,
        child: TransectionList(transections, deletefun));
    final pagebody = SafeArea(
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
          if (!islandscape) ..._buildPortait(mq, appbarvar, _trlcontainer),
          if (islandscape)
            ..._buildLandscape(mq, appbarvar, _trlcontainer, _switch)
        ])));

    return /* Platform.isIOS
        ? CupertinoPageScaffold(
            child: pagebody,
            navigationBar: appbarvar,
          )
        : */
        Scaffold(
      appBar: appbarvar,
      body: pagebody,
      floatingActionButton:
          //Platform.isIOS
          //? Container()
          // :
          FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _startaddnewtrans(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class Chart extends StatelessWidget {
  final List<Transection> recenttransections;
  Chart(this.recenttransections);

  List<Map<String, Object>> get groupedTransectionValues {
    return List.generate(7, (index) {
      final dto = DateTime.now().subtract(Duration(days: index));
      final weekday = DateTime(dto.weekday).toString().substring(3, 4);
      final days = ['M', 'T', 'W', 'Th', 'F', 'S', 'S'];
      var totalexpanse = 0.0;
      for (int i = 0; i < recenttransections.length; i++) {
        if (recenttransections[i].date.day == dto.day &&
            recenttransections[i].date.month == dto.month &&
            recenttransections[i].date.year == dto.year) {
          totalexpanse += recenttransections[i].amount;
        }
      }

      return {'day': days[int.parse(weekday) - 1], 'amount': totalexpanse};
    }).reversed.toList();
  }

  double get weeksum {
    return groupedTransectionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        margin: EdgeInsets.all(15),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransectionValues.map((tx) {
                return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(tx['day'], tx['amount'],
                        weeksum == 0 ? 0 : (tx['amount'] as double) / weeksum));
              }).toList(),
            )));
  }
}

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentage;
  const ChartBar(this.label, this.amount, this.percentage);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(children: <Widget>[
        Container(
            child: FittedBox(child: Text(amount.toStringAsFixed(0))),
            height: constraints.maxHeight * 0.15),
        SizedBox(height: constraints.maxHeight * 0.05),
        Container(
            height: constraints.maxHeight * 0.6,
            width: constraints.maxWidth * .3,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 222, 1),
                      borderRadius: BorderRadius.circular(20)),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20))),
                )
              ],
            )),
        SizedBox(height: constraints.maxHeight * 0.05),
        Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label))),
      ]);
    });
  }
}
